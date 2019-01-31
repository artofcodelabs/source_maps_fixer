# frozen_string_literal: true

module FixSourceMapsHelpers
  ORIGINAL_CSS_SM_URL = '/*# sourceMappingURL=application.css.map*/'
  COMPILED_CSS_SM_URL = '/*# sourceMappingURL=application.css-955bd5a4593a7de76455672f49e450d0b278304b00ad4008028ebceedd47311a.map*/'

  ORIGINAL_JS_SM_URL = '//# sourceMappingURL=application.js.map'
  COMPILED_JS_SM_URL = '//# sourceMappingURL=application.js-0c3ca5eaf24d04fc657ba1de3511dec1c1bb214ee56ce9074c19a273160869a1.map'

  def fix_source_maps_teardown
    revert_js_file
    revert_css_file
  end

  def path_to_js_bundle file_name
    File.join Rails.root, 'app', 'assets', 'output', file_name
  end

  def revert_js_file
    text = File.read(path_to_js_bundle('application.js'))
    new_contents = text.sub(COMPILED_JS_SM_URL, ORIGINAL_JS_SM_URL)
    File.open(path_to_js_bundle('application.js'), 'w') { |file| file.puts new_contents }
  end

  def revert_css_file
    text = File.read(path_to_js_bundle('application.css'))
    new_contents = text.sub(COMPILED_CSS_SM_URL, ORIGINAL_CSS_SM_URL)
    File.open(path_to_js_bundle('application.css'), 'w') { |file| file.puts new_contents }
  end
end

