<template>
  <nav class="pagination" role="navigation" aria-label="pagination">
    <a class="pagination-previous" @click="previousPage">Prev</a>
    <a class="pagination-next" @click="nextPage">Next</a>
    <ul class="pagination-list">
      <li>
        <a  v-for="p in pages"
            :class="current_page == p ? 'pagination-link is-current' : 'pagination-link'"
            :aria-label="'Goto page ' + p"
            @click="goToPage(p)">
              {{p}}
         </a>
      </li>
    </ul>
  </nav>
</template>

<script>
export default {
  name: 'Pagination',

  props: {
    pages: Number,
    current_page: Number
  },

  methods: {
    goToPage(page) {
      this.$parent.page = page
    },

    previousPage () {
      if (this.$parent.page > 1) {
        this.$parent.page -= 1
      } else {
        this.$parent.page = 1
      }
    },

    nextPage () {
      if (this.$parent.page < this.$parent.meta.total_pages) {
        this.$parent.page += 1
      } else {
        this.$parent.page = this.$parent.meta.total_pages
      }
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
