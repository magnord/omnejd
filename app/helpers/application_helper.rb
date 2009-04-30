# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def submit_button(text='Submit')
    content_tag :button, image_tag('/stylesheets/blueprint/plugins/buttons/icons/tick.png', :alt => '') + ' ' + text, 
                :type => 'submit', :class => 'button positive'
  end
  
  def cancel_button(text, path)
    link_to image_tag("/stylesheets/blueprint/plugins/buttons/icons/cross.png", :alt => '') + ' ' + text, path,
            :class => 'button negative'
  end
  
  def change_password_button(text, path)
    link_to image_tag("/stylesheets/blueprint/plugins/buttons/icons/key.png", :alt => '') + ' ' + text, path,
            :class => 'button'
  end

end

