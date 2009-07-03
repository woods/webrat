require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe "field_by_xpath" do
  it "should match the first field that matches the given xpath" do
    with_html <<-HTML
      <html>
        <form>
        <label for="element_42">The Label</label>
        <input type="text" id="element_42">
        </form>
      </html>
    HTML

    field = field_by_xpath(".//input")
    field.should_not be_nil
    field.id.should == "element_42"
  end
end

describe "fields_by_xpath" do
  describe "with matching fields" do
    it "should return all fields that match the given xpath" do
      with_html <<-HTML
        <html>
          <form>
          <label for="element_41">The Label</label>
          <input type="checkbox" id="element_41">
          <label for="element_42">The Label</label>
          <input type="text" id="element_42">
          <label for="element_43">The Label</label>
          <input type="checkbox" id="element_43">
          <label for="element_44">The Label</label>
          <input type="checkbox" id="element_44">
          </form>
        </html>
      HTML
    
      fields = fields_by_xpath(".//input[@type='checkbox']")
      fields.length.should == 3
      fields[0].id.should == 'element_41'
      fields[1].id.should == 'element_43'
      fields[2].id.should == 'element_44'
    end
  end
  
  describe "with no matching fields" do
    it "should return an empty array" do
      with_html <<-HTML
        <html>
          <form>
          <label for="element_42">The Label</label>
          <input type="text" id="element_42">
          </form>
        </html>
      HTML

      fields = fields_by_xpath(".//input[@type='checkbox']")
      fields.should be_empty
    end
  end
end