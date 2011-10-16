require 'test_helper'

class LoginandcreatenewpostTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "login newpost reply back like edit show back delete" do
      visit(logins_path)
      assert true
      fill_in("q", :with => "mvkantra")
      fill_in("y", :with => "pichi")
      click_button("Submit")
      assert page.has_content?('All Posts')
      click_on('New Post')
      assert page.has_content?('New Post')
      find_field('con').set('nc state rocks')
      find_field('post').set('nc state')
      click_on("Create Post")
      fill_in("rep", :with=> 'yayyyyyyyy')
      click_on('Reply')
      find(:xpath, "//a/img[@alt='back']/..").click
      assert page.has_content?('All Posts')
      find(:xpath, "//a/img[@alt='like']/..").click
      find(:xpath, "//a/img[@alt='edit']/..").click
      find_field('con').set('nc state rocks-----yessss')
      find_field('post').set('nc state university')
      click_on('Update Post')
      fill_in("rep", :with=> 'its a good update')
      click_on('Reply')
      find(:xpath, "//a/img[@alt='back']/..").click
      find(:xpath, "//a/img[@alt='show']/..").click
      find(:xpath, "//a/img[@alt='back']/..").click
      find(:xpath, "//a/img[@alt='delete']/..").click
      click_on('Logout')
    end

  test "login as admin create user view all users show edit delete users" do
          visit(logins_path)
          assert true
          fill_in("q", :with => "admin")
          fill_in("y", :with => "admin")
          click_button("Submit")
           click_button("New User")

           find_field('uname').set('dheeraj')
           find_field('upwd').set('dheeraj12')
           find_field('uid').set('dheeraj2')
           find_field('uty').set('0')
           click_button("Create User")
           click_link("Edit")
          find_field('upwd').set('dheeraj12345')
          click_on("Update User")
           click_on('BackChannel Application')
           click_on("View all users")
          find(:xpath, "//a/img[@alt='ashow']/..").click
           click_on('BackChannel Application')
          click_on("View all users")
          find(:xpath, "//a/img[@alt='aedit']/..").click
          find_field('uname').set('achyuth')
          find_field('upwd').set('achyuth12')
                     find_field('uid').set('achyuth2')
                     find_field('uty').set('0')
          click_on("Update User")
          page.has_content?("User was successfully updated.")
          click_on('BackChannel Application')
          click_on("View all users")
          find(:xpath, "//a/img[@alt='aremove']/..").click
          page.has_content?('All Users')
           click_on('Logout')

  end

  test "search by user and content" do
    visit(logins_path)
    select("search by post content", :from => "name")
    fill_in("l", :with =>"hello")
    click_on("Search")
    page.has_content?('All Posts')
    click_on("BackChannel Application")
    select("search by user", :from => "name")
    fill_in("l", :with =>"mvkantra")
    click_on("Search")
    page.has_content?('All Posts')
    click_on("BackChannel Application")

  end

   test "create new user and login" do
     visit(logins_path)
     click_on('New User')
     find_field('uname').set('xyz')
    find_field('upwd').set('xyzzzzz12')
    find_field('uid').set('xyz2')
     click_on('Create User')
     fill_in("q", :with => "xyz")
      fill_in("y", :with => 'xyzzzzz12')
     click_on('Submit')
     page.has_content?('All Posts')
     click_on('Logout')
   end


end

