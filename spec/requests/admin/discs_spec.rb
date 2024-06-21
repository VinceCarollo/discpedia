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

    describe 'PATCH /admin/discs/:id' do
      let(:new_attributes) do
        {
          name: 'Teebird',
          slug: 'teebird',
          speed: 7,
          glide: 4,
          turn: -0,
          fade: 2,
          diameter: 21.3,
          height: 1.3,
          rim_depth: 1.3,
          rim_width: 2.3
        }
      end

      before do
        patch admin_disc_url(disc), params: { disc: new_attributes }
      end

      it 'updates disc name' do
        disc.reload
        expect(disc.name).to eq(new_attributes[:name])
      end

      it 'updates disc slug' do
        disc.reload
        expect(disc.slug).to eq(new_attributes[:slug])
      end

      it 'updates disc speed' do
        disc.reload
        expect(disc.speed).to eq(new_attributes[:speed])
      end

      it 'updates disc glide' do
        disc.reload
        expect(disc.glide).to eq(new_attributes[:glide])
      end

      it 'updates disc turn' do
        disc.reload
        expect(disc.turn).to eq(new_attributes[:turn])
      end

      it 'updates disc fade' do
        disc.reload
        expect(disc.fade).to eq(new_attributes[:fade])
      end

      it 'updates disc diameter' do
        disc.reload
        expect(disc.diameter).to eq(new_attributes[:diameter])
      end

      it 'updates disc height' do
        disc.reload
        expect(disc.height).to eq(new_attributes[:height])
      end

      it 'updates disc rim depth' do
        disc.reload
        expect(disc.rim_depth).to eq(new_attributes[:rim_depth])
      end

      it 'updates disc rim width' do
        disc.reload
        expect(disc.rim_width).to eq(new_attributes[:rim_width])
      end

      it 'redirects to the disc' do
        disc.reload
        expect(response).to redirect_to(admin_discs_url)
      end

      context 'with bad params' do
        let(:new_attributes) { { name: '' } }

        it 'returns unprocessable' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'renders edit' do
          expect(response).to render_template(:edit)
        end
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
