# From ruby:2.5
FROM ruby:2.5

# Run apt update
RUN apt-get update -qq

# Run to install nodejs
RUN apt-get install -y nodejs

# Run to install postgresql-client
RUN apt-get install -y postgresql-client

# Make /notesapi directory
RUN mkdir /notesapi

# Define Workon directory
WORKDIR /notesapi

# Copy Gemfile and Gemfile.lock
COPY Gemfile /notesapi/Gemfile
COPY Gemfile.lock /notesapi/Gemfile.lock

# Bundle Install
RUN bundle install

# Copy current files to notesapi
COPY . /notesapi

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
