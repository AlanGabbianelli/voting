require 'rails_helper'
require 'web_helper'

RSpec.feature 'User visits the voting portal', type: :feature do
  context 'when the page is not populated' do
    before(:each) { visit(campaigns_path) }

    scenario 'they see the title' do
      within('h1') { expect(page).to have_content('Campaigns') }
    end

    scenario 'they see the headers' do
      within('table/thead') do
        expect(page).to have_content('Name')
        expect(page).to have_content('Valid Votes')
        expect(page).to have_content('Invalid Votes')
        expect(page).to have_content('Total Votes')
      end
    end

    scenario 'they do not see the campaigns' do
      within('table/tbody') do
        expect(page).to_not have_link('ssss_uk_01B')
        expect(page).to_not have_content('ssss_uk_01B 10 0 10')
      end
    end
  end

  context 'when the page is populated' do
    before(:each) { run_the_rake_task && visit(campaigns_path) }

    scenario 'they see the title' do
      within('h1') { expect(page).to have_content('Campaigns') }
    end

    scenario 'they see the headers' do
      within('table/thead') do
        expect(page).to have_content('Name')
        expect(page).to have_content('Valid Votes')
        expect(page).to have_content('Invalid Votes')
        expect(page).to have_content('Total Votes')
      end
    end

    scenario 'they see the campaigns' do
      within('table/tbody') do
        expect(page).to have_link('ssss_uk_01B')
        expect(page).to have_content('ssss_uk_01B 10 0 10')
      end
    end

    context 'when they click on a campaign' do
      before(:each) { click_link('ssss_uk_01B') }

      scenario 'they see the title' do
        within('h1') { expect(page).to have_content('Campaign: ssss_uk_01B') }
      end

      scenario 'they see the headers' do
        within('table/thead') do
          expect(page).to have_content('Candidate')
          expect(page).to have_content('Valid Votes')
          expect(page).to have_content('Invalid Votes')
          expect(page).to have_content('Total Votes')
        end
      end

      scenario 'they see the choices' do
        within('table/tbody') do
          expect(page).to have_content('Antony 1 0 1')
          expect(page).to have_content('Leon 1 0 1')
          expect(page).to have_content('Tupele 4 0 4')
          expect(page).to have_content('Jane 2 0 2')
          expect(page).to have_content('Mark 1 0 1')
          expect(page).to have_content('Verity 1 0 1')
        end
      end
    end
  end
end
