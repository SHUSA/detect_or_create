require 'spec_helper'

describe DetectOrCreate do
  before(:all) { class User < ActiveRecord::Base; end; }

  it 'validates required arguments exist' do
    expect { User.detect_or_create() }.
      to raise_error(StandardError, "Missing Arguments: `by`")
  end

  it 'validates :by type' do
    expect { User.detect_or_create(:by => ['id = ?', 1]) }.
      to raise_error(StandardError, "`by` must be a Hash")
  end

  it 'validates :with type' do
    expect { User.detect_or_create(:by => {:name => 'name'},
                                   :with => 1) }.
      to raise_error(StandardError, "`with` must be a Hash")
  end

  it 'validates :by values' do
    expect { User.detect_or_create(:by => {}) }.
      to raise_error(StandardError, "Missing keys to filter by")
  end
end

