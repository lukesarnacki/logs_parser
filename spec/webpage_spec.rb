require_relative '../web_page'

RSpec.describe WebPage do
  it 'increases view for any ip and unique view only for umique ips' do
    web_page = WebPage.new(path: '/index')

    expect { web_page.record_view("1.1.1.1") }
      .to change { web_page.views }.by(1)
      .and change { web_page.unique_views }.by(1)

    expect { web_page.record_view("1.1.1.1") }
      .to change { web_page.views }.by(1)
      .and change { web_page.unique_views }.by(0)

    expect { web_page.record_view("2.2.2.2") }
      .to change { web_page.views }.by(1)
      .and change { web_page.unique_views }.by(1)
  end
end
