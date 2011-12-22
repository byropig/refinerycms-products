Given /^I have no products$/ do
  Product.delete_all
end

Given /^I (only )?have products titled "?([^\"]*)"?$/ do |only, titles|
  Product.delete_all if only
  titles.split(', ').each do |title|
    Product.create(:name => title)
  end
end

Then /^I should have ([0-9]+) products?$/ do |count|
  Product.count.should == count.to_i
end
