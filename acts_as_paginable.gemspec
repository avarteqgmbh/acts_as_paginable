# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = %q{acts_as_paginable}
  s.version = "0.4.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Julian Fischer"]
  s.date = %q{2011-07-04}
  s.description = %q{Filter records by passing params to a controller. No need to modify the model anymore.}
  s.email = %q{fischer@avarteq.de}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG.textile",
     "MIT-LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION",
     "acts_as_paginable.gemspec",
     "init.rb",
     "lib/acts_as_paginable.rb",
     "test/helper.rb",
     "test/test_acts_as_paginable.rb"
  ]
  s.homepage = %q{http://github.com/avarteq/acts_as_paginable}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.0}
  s.summary = %q{A will_paginate enhancement to automatically receive a filterable pagination method.}
  s.test_files = [
    "test/helper.rb",
     "test/test_acts_as_paginable.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<will_paginate>, ["3.0.pre"])
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<will_paginate>, ["3.0.pre"])
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<will_paginate>, ["3.0.pre"])
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end


