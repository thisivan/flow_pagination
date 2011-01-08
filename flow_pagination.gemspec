# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{flow_pagination}
  s.version = "2.0.1"

  # s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ivan Torres"]
  s.cert_chain = ["/Users/ivan/.ssh/gem-public_cert.pem"]
  s.date = %q{2010-11-01}
  s.description = %q{FlowPagination link renderer plugin for Mislav's WillPaginate plugin (Twitter like pagination).}
  s.email = %q{mexpolk@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/flow_pagination.rb"]
  s.files = ["MIT-LICENSE", "Manifest", "README.rdoc", "Rakefile", "flow_pagination.gemspec", "init.rb", "lib/flow_pagination.rb"]
  s.homepage = %q{http://github.com/mexpolk/flow_pagination}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Flow_pagination", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{flow_pagination}
  s.rubygems_version = %q{1.3.7}
  # s.signing_key = %q{/Users/ivan/.ssh/gem-private_key.pem}
  s.summary = %q{FlowPagination link renderer plugin for Mislav's WillPaginate plugin (Twitter like pagination).}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
