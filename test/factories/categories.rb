# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  code        :string           default(""), not null
#  title       :string           not null
#  description :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :category do
    code "MyString"
title "MyString"
description "MyString"
  end

end
