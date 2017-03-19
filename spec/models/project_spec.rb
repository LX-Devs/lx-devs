require 'rails_helper'

RSpec.describe Project, :type => :model do
  subject { described_class.new(name: "test", description: "test", url: "http://www.example.com", category: "test")}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an url" do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a category" do
    subject.category = nil
    expect(subject).to_not be_valid
  end

  it 'validates the url format' do
    invalid_urls = %w( test http:// www)
    invalid_urls.each do |url|
      subject.url = url
      expect(subject).to be_invalid
    end
  end

  it { should belong_to(:developer) }
end
