require 'rails_helper'

RSpec.describe 'Admin::Discs', type: :request do
  let(:manufacturer) { Manufacturer.create!(name: 'Innova', slug: 'innova') }
  let(:disc) do
    Disc.create!(
      manufacturer:,
      name: 'Destroyer',
      slug: 'destroyer',
      speed: 12,
      glide: 5,
      turn: -1,
      fade: 3,
      diameter: 21.1,
      height: 1.4,
      rim_depth: 1.2,
      rim_width: 2.2
    )
  end

  context 'authenticated as an admin' do
    before do
      allow_any_instance_of(Admin::BaseController)
        .to receive(:authenticate_admin!).and_return(true)
    end

    describe 'GET /admin/discs' do
      it 'renders a successful response' do
        get admin_discs_url
        expect(response).to be_successful
      end
    end

    describe 'GET /admin/discs/:id/edit' do
      it 'renders a successful response' do
        get edit_admin_disc_url(disc)
        expect(response).to be_successful
      end
    end
  end

  context 'not authenticated as an admin' do
    describe 'GET /admin/discs' do
      it 'redirects to the login page' do
        get admin_discs_url
        expect(response).to redirect_to(login_url)
      end
    end

    describe 'GET /admin/discs/:id/edit' do
      it 'redirects to the login page' do
        get edit_admin_disc_url(disc)
        expect(response).to redirect_to(login_url)
      end
    end
  end
end
