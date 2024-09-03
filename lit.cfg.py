import lit.formats

config.name = "RVM Tests"
config.test_format = lit.formats.ShTest(True)
config.suffixes = ['.ml', '.py']