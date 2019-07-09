Pod::Spec.new do |s|

  s.name          = "UITextField-Mask"
  s.module_name   = "UITextFieldMask"
  s.version       = "0.1.0"
  s.summary       = "UITextField extension with mask support"
  s.homepage      = "https://github.com/rafaelrsilva/UITextField-Mask"
  s.author        = { "Rafael Ribeiro da Silva" => "eu@rafaelrsilva.com" }
  s.platform      = :ios, "8.0",
  s.swift_version = "5.0"
  s.source        = { :git => "https://github.com/rafaelrsilva/UITextField-Mask.git", :tag => "0.1.0" }
  s.source_files  = "UITextField-Mask/**/*.{h,m,swift}"
  s.license       = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
  
  s.test_spec 'UITextFieldMaskTests' do |test_spec|
    test_spec.source_files = 'UITextField-MaskTests/**/*.{h,m,swift}'
  end
end
