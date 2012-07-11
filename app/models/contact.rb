class Contact < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :phone

  validates :email, :first_name, :last_name, :phone, presence: true
  validates :phone, length:{ in: 10..11 }
  validates :email, uniqueness: { case_sensitive: false }

  before_save { |contact| contact.email = email.downcase }

  default_scope order: 'contacts.created_at DESC'

  has_and_belongs_to_many(:contacts,
    :join_table => "contact_connections",
    :foreign_key => "contact_a_id",
    :association_foreign_key => "contact_b_id")

  def is_connected?(other_user)
    begin
      return self.contacts.find(other_user)
    rescue
      return false
    end
  end

  def connect(other_user)
    self.contacts.push(other_user)
    other_user.contacts.push(self)
  end

  def phone=(num)
    num.gsub!(/\D/, '') if num.is_a?(String)
    super(num)
  end
end
