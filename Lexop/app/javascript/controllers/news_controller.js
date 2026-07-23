import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "authors", "categories"];

  page = 1;
  maxPage = -1;
  author = "";
  category = "";

  connect() {
    this.fetchNews(this.page, this.author, this.category);
    this.fetchAuthors();
    this.fetchCategories();
  }

  nextPage() {
    if (this.page < this.maxPage) {
      this.page += 1;
      this.fetchNews(this.page, this.author, this.category);
      this.scrollTop();
    }
  }

  previousPage() {
    if (this.page > 1) {
      this.page -= 1;
      this.fetchNews(this.page, this.author, this.category);
      this.scrollTop();
    }
  }

  scrollTop() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
  }

  fetchCategories() {
    let html = "";
    fetch("/api/v1/categories")
      .then((response) => response.json())
      .then((data) => {
        if (data.data && data.data.categories) {
          const categories = data.data.categories;
          html +=
            '<option value="" selected disabled hidden>Filter categories</option>' +
            '<option value="ALL">All categories</option>';
          categories.forEach((category) => {
            html += "<option>" + category + "</option>";
          });
          this.categoriesTarget.innerHTML = html;
        }
      });
  }

  filterCategories(event) {
    const category = event.target.options[event.target.selectedIndex].value;
    if (category) {
      this.page = 1;
      this.category = category;
      this.fetchNews(this.page, this.author, this.category);
    }
  }

  filterAuthors(event) {
    const author = event.target.options[event.target.selectedIndex].value;
    if (author) {
      this.page = 1;
      this.author = author;
      this.fetchNews(this.page, this.author, this.category);
    }
  }

  fetchAuthors() {
    let html = "";
    fetch("/api/v1/authors")
      .then((response) => response.json())
      .then((data) => {
        if (data.data && data.data.authors) {
          const authors = data.data.authors;
          html +=
            '<option value="" selected disabled hidden>Filter author</option>' +
            '<option value="ALL">All authors</option>';
          authors.forEach((author) => {
            html += "<option>" + author + "</option>";
          });
          this.authorsTarget.innerHTML = html;
        }
      });
  }

  fetchNews(page = 1, author = "", category = "") {
    let html = "";
    fetch(this.buildURL(page, author, category))
      .then((response) => response.json())
      .then((data) => {
        if (data.data.pagination) {
          console.log(data.data.pagination);
          this.maxPage = data.data.pagination.last;
        }
        if (data.data && data.data.articles) {
          data.data.articles.forEach((article) => {
            html +=
              '<div class="article" data-action="click->news#showArticle" data-title="' +
              article.title +
              '"><h1 class="title">' +
              article.title +
              '</h1><small>Published <time datetime="' +
              article.publication_date +
              '">' +
              article.publication_date +
              "</time>" +
              '&nbsp;By&nbsp;<span class="author">' +
              article.author +
              '</span>&nbsp;In&nbsp;<span class="category">' +
              article.category +
              "</span></small>" +
              "<p>" +
              article.excerpt +
              "</p></div>";
          });
          this.containerTarget.innerHTML = html;
        }
      })
      .catch((error) => console.error(error));
  }

  showArticle(event) {
    let html = "";
    const title = event.target.dataset.title;
    fetch("/api/v1/news_articles/" + title)
      .then((response) => response.json())
      .then((data) => {
        if (data.data && data.data.article) {
          const article = data.data.article;
          html += '<h1 class="title">' + article.title + "</h1>";
          html +=
            '<small>Published <time datetime="' +
            article.publication_date +
            '">' +
            article.publication_date +
            "</time>" +
            '&nbsp;By&nbsp;<span class="author">' +
            article.author +
            '</span>&nbsp;In&nbsp;<span class="category">' +
            article.category +
            "</span></small>";
          html += article.html_content;
          this.containerTarget.innerHTML = html;
        }
      })
      .catch((error) => console.error(error));
  }

  buildURL(page, author, category) {
    let url = "/api/v1/news_articles?";
    if (page) {
      url += `page=${page}`;
    }
    if (author && author != "ALL") {
      url += `&author=${author}`;
    }
    if (category && category != "ALL") {
      url += `&category=${category}`;
    }
    return url;
  }
}
