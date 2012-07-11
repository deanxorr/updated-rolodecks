require 'spec_helper'

describe Contact do
  before do
    @contact = Contact.new(
      email: "test@user.com",
      first_name: "Test",
      last_name: "User",
      phone: "6175551212"
      )
  end

  subject { @contact }

  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :email }
  it { should respond_to :phone }
  it { should be_valid }

  describe "validation errors" do
    subject { @contact }

    it "should require email" do
      @contact.email = ""
      should_not be_valid
    end

    it "should require first_name" do
      @contact.first_name = ""
      should_not be_valid
    end

    it "should require last_name" do
      @contact.last_name = ""
      should_not be_valid
    end

    it "should require phone" do
      @contact.phone = ""
      should_not be_valid
    end

    it "should have phone be 10 or 11 digits long" do
      @contact.phone = "1234567890"
      should be_valid

      @contact.phone = "12345678901"
      should be_valid

      @contact.phone = "123456789"
      should_not be_valid
    end

    it "should require unique email" do
      @contact.save
      @contact_dupe = @contact.dup
      @contact_dupe.should_not be_valid
    end

    it "should require a unique email, case insensitive" do
      @contact.save
      @contact_dupe = @contact.dup
      @contact_dupe.email = @contact.email.upcase
      @contact_dupe.should_not be_valid
    end
  end

  describe "scopes and ordering" do
    it "should have contacts in the right order" do
      @contact_older = Contact.create(
                          email: Random.email,
                          first_name: Random.firstname,
                          last_name: Random.lastname,
                          phone: Random.phone
                        )
      @contact_newer = Contact.create(
                          email: Random.email,
                          first_name: Random.firstname,
                          last_name: Random.lastname,
                          phone: Random.phone
                        )

      @contact_older.created_at = 1.day.ago
      @contact_newer.created_at = 1.hour.ago
      @contact_older.save
      @contact_newer.save

      Contact.all.should == [@contact_newer, @contact_older]
    end
  end

  describe "connections to other contacts" do
    let(:contact_self) do
      Contact.create! do |contact|
        contact.email = Random.email
        contact.first_name = Random.firstname
        contact.last_name = Random.lastname
        contact.phone = Random.phone
      end
    end
    let(:contact_other_connected) do
      Contact.create! do |contact|
        contact.email = Random.email
        contact.first_name = Random.firstname
        contact.last_name = Random.lastname
        contact.phone = Random.phone
      end
    end
    let(:contact_not_connected) do
      Contact.create! do |contact|
        contact.email = Random.email
        contact.first_name = Random.firstname
        contact.last_name = Random.lastname
        contact.phone = Random.phone
      end
    end
    it "should be able to return true if connected to a given contact" do
      contact_self.connect(contact_other_connected) ## need to add connect method
      contact_self.is_connected?(contact_other_connected).should be_true
      contact_other_connected.is_connected?(contact_self).should be_true
    end
    it "should be able to return false if not connected to a given contact" do
      contact_self.is_connected?(contact_not_connected).should_not be_true
    end
  end

end
