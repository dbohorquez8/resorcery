module ManageCreationErrors
  extend ActiveSupport::Concern

  def creation_error(errors)
    response = {
      response: [],
      error: "invalid_resource",
      error_description: "We could not save your data",
      messages: errors.messages
    }
    expose response
  end
end
