abstract class MainLayout
  include Lucky::HTMLPage

  abstract def content
  abstract def page_title

  # The default page title. It is passed to `Shared::LayoutHead`.
  #
  # Add a `page_title` method to pages to override it. You can also remove
  # This method so every page is required to have its own page title.
  def page_title
    "Welcome"
  end

  def render
    html_doctype

    html lang: "en" do
      mount Shared::LayoutHead.new(page_title: page_title, context: @context)

      body class: "font-sans text-grey-darkest leading-tight bg-grey-lighter" do
        mount Shared::Header.new(@context.request)
        div class: "bg-blue-gradient" do
          div class: "py-10 md:py-16 px-6 sm:px-10 mx-auto container text-center text-white" do
            div class: "mx-auto md:px-32" do
              h1 "Build lightning fast web apps with fewer bugs", class: "leading-normal font-light text-3xl md:text-4xl"

              para class: "opacity-75 sm:px-10 leading-loose mt-10 text-lg sm:text-xl" do
                text <<-TEXT
              Lucky is a web framework written in Crystal. It helps you
              prototype quickly, catch bugs at compile time, and deliver
              responses quickly.
              TEXT
              end

              div class: "my-10" do
                link "View on GitHub", "https://github.com/luckyframework/lucky", class: "btn btn--blue w-full sm:w-auto sm:mr-5"
                link "Get Started", Guides::GettingStarted::Installing, class: "btn w-full sm:w-auto mt-6 sm:mt-0"
              end
            end
          end
        end
        render_main_content
      end
    end
  end

  private def render_main_content
    div class: "container mx-auto px-6 py-5" do
      mount Shared::FlashMessages.new(@context.flash)
      2.times do
        div class: "flex md:w-2/3 mx-auto mt-8" do
          content_block "Say goodbye to slow", <<-TEXT
          A simple hello world response is returned in 0.1ms. Rendering
          complex HTML takes 1ms.
          TEXT

          content_block "Batteries included", <<-TEXT
          Authentication, asset management, CORS, database ORM, and more can
          all be included when creating a new Lucky project.
          TEXT
        end
      end
    end
  end

  private def content_block(title, body)
    div class: "md:w-1/2 px-5" do
      h3 title, class: "mb-3 text-teal-dark font-normal text-lg"
      para body, class: "leading-loose"
    end
  end
end
