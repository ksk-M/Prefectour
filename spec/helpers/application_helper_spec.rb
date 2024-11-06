require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "ページタイトル" do
    it 'page_titleがnilの時、ページタイトルが正しく表示されること' do
      expect(full_title(nil)).to eq('Prefectour')
    end

    it 'page_titleが空白の時、ページタイトルが正しく表示されること' do
      expect(full_title('')).to eq('Prefectour')
    end

    it 'page_titleが渡されている時、ページタイトルが動的に表示されること' do
      expect(full_title('Test')).to eq('Test | Prefectour')
    end
  end
end
