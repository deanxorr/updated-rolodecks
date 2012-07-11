Given /^There is a contact 'bob' I want to connect to and I am logged in$/ do

  @me = Contact.new
  @me.email = Random.email
  @me.first_name = 'Not Bob'
  @me.last_name = Random.last_name
  @me.phone = Random.phone
  @me.save!
  
  visit contact_path(@me)
  click_on 'Login'

  @bob = Contact.new
  @bob.email = Random.email
  @bob.first_name = 'Bob'
  @bob.last_name = 'Robertson'
  @bob.phone = Random.phone
  @bob.save!
end

When /^I go to my suggested contacts page$/ do
  visit contacts_path
end

When /^I press the connect button next to 'bob'$/ do
  click_on 'Connect to Bob'
end

Then /^I add 'bob' to my connections$/ do
  
  page.find("tr#BobRobertson").should have_content 'Connected'

end