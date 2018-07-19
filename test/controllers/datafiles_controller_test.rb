require 'test_helper'

class DatafilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @datafile = datafiles(:one)
  end

  test "should get index" do
    get datafiles_url
    assert_response :success
  end

  test "should get new" do
    get new_datafile_url
    assert_response :success
  end

  test "should create datafile" do
    assert_difference('Datafile.count') do
      post datafiles_url, params: { datafile: { dataset_id: @datafile.dataset_id, filename: @datafile.filename, size: @datafile.size, storage_key: @datafile.storage_key, storage_prefix: @datafile.storage_prefix, storage_root: @datafile.storage_root, web_id: @datafile.web_id } }
    end

    assert_redirected_to datafile_url(Datafile.last)
  end

  test "should show datafile" do
    get datafile_url(@datafile)
    assert_response :success
  end

  test "should get edit" do
    get edit_datafile_url(@datafile)
    assert_response :success
  end

  test "should update datafile" do
    patch datafile_url(@datafile), params: { datafile: { dataset_id: @datafile.dataset_id, filename: @datafile.filename, size: @datafile.size, storage_key: @datafile.storage_key, storage_prefix: @datafile.storage_prefix, storage_root: @datafile.storage_root, web_id: @datafile.web_id } }
    assert_redirected_to datafile_url(@datafile)
  end

  test "should destroy datafile" do
    assert_difference('Datafile.count', -1) do
      delete datafile_url(@datafile)
    end

    assert_redirected_to datafiles_url
  end
end
