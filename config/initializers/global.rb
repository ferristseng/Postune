Settings = YAML.load(File.open(Rails.root.join('config', 'settings.yml')))[Rails.env]