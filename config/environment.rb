# Load the Rails application.
require File.expand_path('../application', __FILE__)


#formatos de fecha DATETIME, no DATE
#databona = d-m-a
#uso: <%= modelo.registrodatetime.to_s(:due_time) %>
#requiere reiniciar server
Time::DATE_FORMATS[:databona] = '%d-%m-%Y'

# Initialize the Rails application.
Rails.application.initialize!
