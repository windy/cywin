# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :foundation, class: :input, hint_class: :field_with_hint, error_class: :error do |b|
    #b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper :label_input, class: 'row' do |ba|
      ba.wrapper class: 'small-12 medium-8 large-6 columns' do |baa|
        baa.use :label
        baa.use :input
        baa.use :error, wrap_with: { tag: 'small', class: 'error' }
      end
    end
  end
  
  config.wrappers :foundation_no_style, class: :input, hint_class: :field_with_hint, error_class: :error do |b|
    #b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper :label_input, class: 'row' do |ba|
      ba.wrapper class: 'small-12 columns' do |baa|
        baa.use :input
        baa.use :error, wrap_with: { tag: 'small', class: 'error' }
      end
    end
  end

  # CSS class for buttons
  config.button_class = 'button'

  config.label_class = ''

  # CSS class to add for error notification helper.
  config.error_notification_class = 'alert-box alert'

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :foundation
end

SimpleForm.browser_validations = false
