require 'rails_helper'

RSpec.describe Developer, :type => :model do
  subject { described_class.new(username: "test", first_name: "test", last_name: "test", title: "test", description: "test", language1: "Ruby") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a first name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a last name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a language" do
    subject.language1 = nil
    expect(subject).to_not be_valid
  end
  it "is not valid if language is not included in the list of languages" do
    subject.language2 = "test"
    expect(subject).to_not be_valid
  end
end
