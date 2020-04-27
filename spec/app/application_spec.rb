# frozen_string_literal: true

require 'spec_helper'
require 'sinatra_helper'
require 'capybara_helper'
require 'vcr_helper'

RSpec.describe Sinatra::Application do
  describe 'GET /', vcr: { cassette_name: 'recipes' } do
    it 'returns status 200' do
      get '/'

      expect(last_response).to be_ok
    end

    it 'displays recipes titles', :view do
      visit '/'

      %w[
        White Cheddar Grilled Cheese with Cherry Preserves & Basil
        Tofu Saag Paneer with Buttery Toasted Pita
        Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing
        Crispy Chicken and Rice with Peas & Arugula Salad
      ].each do |title|
        expect(page).to have_text title
      end
    end

    it 'displays recipes images', :view do
      visit '/'

      images_urls = page.find_all('img').map { |image| image['src'] }
      # TODO: Refactor Expectation to not be this mess.
      expect(images_urls).to match_array(
        [
          '//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg', # rubocop:disable Layout/LineLength
          '//images.ctfassets.net/kk2bw5ojx476/48S44TRZN626y4Wy4CuOmA/9c0a510bc3d18dda9318c6bf49fac327/SKU1498_Hero_154__2_-adb6124909b48c69f869afecb78b6808-2.jpg', # rubocop:disable Layout/LineLength
          '//images.ctfassets.net/kk2bw5ojx476/3TJp6aDAcMw6yMiE82Oy0K/2a4cde3c1c7e374166dcce1e900cb3c1/SKU1503_Hero_102__1_-6add52eb4eec83f785974ddeac3316b7.jpg', # rubocop:disable Layout/LineLength
          '//images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg' # rubocop:disable Layout/LineLength
        ]
      )
    end

    it 'links to detailed view' do
      visit '/'

      links = page.find_all('a').map { |link| link['href'] }

      expect(links).to match_array %w[/4dT8tcb6ukGSIg2YyuGEOm
                                      /5jy9hcMeEgQ4maKGqIOYW6
                                      /2E8bc3VcJmA8OgmQsageas
                                      /437eO3ORCME46i02SeCW46]
    end
  end

  describe 'GET /:id', vcr: { cassette_name: 'recipe' } do
    it 'returns status 200' do
      get '/2E8bc3VcJmA8OgmQsageas'

      expect(last_response).to be_ok
    end

    it 'displays recipe title', :view do
      visit '/2E8bc3VcJmA8OgmQsageas'

      expect(page).to have_text 'Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing'
    end

    it 'displays recipe image', :view do
      visit '/2E8bc3VcJmA8OgmQsageas'

      image_url = page.find('img')['src']

      expect(image_url).to eq '//images.ctfassets.net/kk2bw5ojx476/3TJp6aDAcMw6yMiE82Oy0K/2a4cde3c1c7e374166dcce1e900cb3c1/SKU1503_Hero_102__1_-6add52eb4eec83f785974ddeac3316b7.jpg' # rubocop:disable Layout/LineLength
    end

    context 'when recipe has tags' do
      it 'displays recipe tags', :view do
        visit '/437eO3ORCME46i02SeCW46'

        expect(page).to have_selector('div#tags')
        expect(page).to have_text 'gluten free, healthy'
      end
    end

    context 'when recipe does not have tags' do
      it 'does not displays recipe tags', :view do
        visit '/2E8bc3VcJmA8OgmQsageas'

        expect(page).not_to have_selector('div#tags')
      end
    end

    it 'displays recipe details', :view do
      visit '/2E8bc3VcJmA8OgmQsageas'

      expect(page).to have_text(
        'Warmer weather means the ushering in of grill season and this recipe completely ' \
        'celebrates the grill (or grill pan)! Squash and green beans are nicely charred then take a bath in a zesty ' \
        'cilantro-jalapeño dressing. After the steaks are perfectly seared, the same dressing does double duty as ' \
        'a tasty finishing sauce. A fresh radish salad tops it all off for crunch and a burst of color. ' \
        'Cook, relax, and enjoy!'
      )
    end

    context 'when recipe has a chef' do
      it 'displays chef name', :view do
        visit '/2E8bc3VcJmA8OgmQsageas'

        expect(page).to have_selector('div#chef')
        expect(page).to have_text 'Mark Zucchiniberg'
      end
    end

    context 'when recipe does not have a chef' do
      it 'does not display chef name', :view do
        visit '/4dT8tcb6ukGSIg2YyuGEOm'

        expect(page).not_to have_selector('div#chef')
      end
    end
  end
end
