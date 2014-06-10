json.success true
json.data do
  json.array! @person_requires do |person_require|
    json.partial! 'person_require', person_require: person_require
  end
end
