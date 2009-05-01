# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #
  # Button to be used inside a form, to submit it
  #
  def submit_button(text='Submit')
    content_tag :button, image_tag('/stylesheets/blueprint/plugins/buttons/icons/tick.png', :alt => '') + ' ' + text, 
                :type => 'submit', :class => 'button positive'
  end
  
  
  #
  # General button for cancel operations, etc
  #
  def cancel_button(text, path)
    link_to image_tag("/stylesheets/blueprint/plugins/buttons/icons/cross.png", :alt => '') + ' ' + text, path,
            :class => 'button negative'
  end
  
  
  #
  # Specialized button for password-related stuff
  #
  def change_password_button(text, path)
    link_to image_tag("/stylesheets/blueprint/plugins/buttons/icons/key.png", :alt => '') + ' ' + text, path,
            :class => 'button'
  end


  #
  # Use this at the top of views to activate TinyMCE editor functionality
  #
  def use_tinymce
    # Avoid multiple inclusions
    @content_for_tinymce = ""
    content_for :tinymce do
      javascript_include_tag('tiny_mce/tiny_mce') + javascript_include_tag('mce_editor')
    end
  end

end

