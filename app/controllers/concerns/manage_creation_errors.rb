module ManageCreationErrors
  extend ActiveSupport::Concern

  def creation_error(errors, metadata = {})
    response = {
      response: [],
      error: "invalid_resource",
      error_description: "We could not save your data",
      messages: errors.messages
    }
    expose response, metadata: metadata
  end
end
