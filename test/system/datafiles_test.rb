require "application_system_test_case"

class DatafilesTest < ApplicationSystemTestCase
  setup do
    @datafile = datafiles(:one)
  end

  test "visiting the index" do
    visit datafiles_url
    assert_selector "h1", text: "Datafiles"
  end

  test "creating a Datafile" do
    visit datafiles_url
    click_on "New Datafile"

    fill_in "Dataset", with: @datafile.dataset_id
    fill_in "Filename", with: @datafile.filename
    fill_in "Size", with: @datafile.size
    fill_in "Storage Key", with: @datafile.storage_key
    fill_in "Storage Prefix", with: @datafile.storage_prefix
    fill_in "Storage Root", with: @datafile.storage_root
    fill_in "Web", with: @datafile.web_id
    click_on "Create Datafile"

    assert_text "Datafile was successfully created"
    click_on "Back"
  end

  test "updating a Datafile" do
    visit datafiles_url
    click_on "Edit", match: :first

    fill_in "Dataset", with: @datafile.dataset_id
    fill_in "Filename", with: @datafile.filename
    fill_in "Size", with: @datafile.size
    fill_in "Storage Key", with: @datafile.storage_key
    fill_in "Storage Prefix", with: @datafile.storage_prefix
    fill_in "Storage Root", with: @datafile.storage_root
    fill_in "Web", with: @datafile.web_id
    click_on "Update Datafile"

    assert_text "Datafile was successfully updated"
    click_on "Back"
  end

  test "destroying a Datafile" do
    visit datafiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Datafile was successfully destroyed"
  end
end
