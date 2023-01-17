# AiStories
### Generate stories for your kids using Artificial Intelligence
Add main characters (your kids), secondary characters (their friends) and a little excerpt and click Generate. A story with images and multiple pages will be generated.

The software uses OpenAI GPT-3 (Davinci-003 and Dall-E) to generate the stories, summaries, titles and images.

The software's Tech Stack: Ruby on Rails + Hotwire.

### Author
Benjamín Silva<br>
[Donate if you liked the project? 🍻](https://www.paypal.com/donate/?hosted_button_id=TKN2THHAQAYX8)

### Screenshots
How to create a story:

<img width="730" alt="Screen Shot 2023-01-13 at 02 25 42" src="https://user-images.githubusercontent.com/4019924/212244002-40009696-c69d-45f5-a30a-b33154c62bd7.png">

How do stories look like:

<img width="1539" alt="image" src="https://user-images.githubusercontent.com/4019924/212244105-592457fd-f6d9-45ce-8308-61ec92fd9e00.png">

### Ruby version
3.2.0
### Rails version
7.0.4
### System dependencies
  - Redis (for websockets)
  - Libvips (for ActiveStorage)
  - PostgreSQL

### Configuration
  - mv .env-example .env
  - Run bin/rails db:encryption:init and copy each key to the .env file
  - Create an OpenAI API Token at https://beta.openai.com/account/api-keys
  - Create a user and add the OpenAI API Token in the settings (it will be encrypted before stored 🔐 ✅)

### Database creation
bin/rails db:create

### Database initialization
bin/rails db:schema:load

### Dependencies installation
  - bundle install
  - yarn install

### How to run the app
  - bin/dev
  - open your browser and go to http://127.0.0.1:3000

### How to run the test suite
No tests yet for this toy project yet.

----

## Contributing
Please send Issues and/or PR<br>
Be kind.

## License

AiStories is released under the [MIT License](https://opensource.org/licenses/MIT).
