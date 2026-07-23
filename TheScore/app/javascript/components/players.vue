<template>
  <section class="section" id="players">
    <div class="container">
      <!-- table controls -->
      <div class="is-clearfix">
        <div class="field has-addons is-pulled-left">
          <div class="control">
            <a class="button is-primary">Filter</a>
          </div>
          <div class="control">
            <input type="text" class="input is-primary" placeholder="Player" v-model="playerFilter">
          </div>
        </div>

        <div class="field is-horizontal is-pulled-right" v-if="players.length > 0">
          <a @click="downloadCSV(sort, sortDirection, page, playerFilter)" class="button is-primary">
            <i class="fas fa-download"></i>
            &nbsp;
            CSV
          </a>
        </div>
      </div>

      <br>

      <div v-if="players.length > 0">

        <!-- table pagination -->
        <Pagination :current_page="meta.current_page" :pages="meta.total_pages"/>

        <!-- table rendering -->
        <div class="table-container">
          <table class="table is-hoverable is-striped is-fullwidth">
            <thead>
              <tr>
                <th width="15%">
                  <a @click="setSort('player')" :class="isActive('player')">
                    Player
                    <i class="fas fa-sort-alpha-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-alpha-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('team')" :class="isActive('team')">
                    Team
                    <i class="fas fa-sort-alpha-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-alpha-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('position')" :class="isActive('position')">
                    <abbr title="Position">Pos</abbr>
                    <i class="fas fa-sort-alpha-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-alpha-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_attempts_per_game')" :class="isActive('rushing_attempts_per_game')">
                    <abbr title="Rushing Attempts Per Game Average">Att/G</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_attempts')" :class="isActive('rushing_attempts')">
                    <abbr title="Rushing Attempts">Att</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('total_rushing_yards')" :class="isActive('total_rushing_yards')">
                    <abbr title="Total Rushing Yards">Yds</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_average_yards_per_attempt')" :class="isActive('rushing_average_yards_per_attempt')">
                    <abbr title="Rushing Average Yards Per Attempt">Avg</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_yards_per_game')" :class="isActive('rushing_yards_per_game')">
                    <abbr title="Rushing Yards Per Game">Yds/G</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('touchdowns')" :class="isActive('touchdowns')">
                    <abbr title="Total Rushing Touchdowns">TD</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('longest_rush')" :class="isActive('longest_rush')">
                    <abbr title="Longest Rush">Lng</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_first_downs')" :class="isActive('rushing_first_downs')">
                    <abbr title="Rushing First Downs">1st</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_first_down_percentage')" :class="isActive('rushing_first_down_percentage')">
                    <abbr title="Rushing First Down Percentage">1st%</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_twenty_or_more_yards_each')" :class="isActive('rushing_twenty_or_more_yards_each')">
                    <abbr title="Rushing 20+ Yards Each">20+</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_forty_or_more_yards_each')" :class="isActive('rushing_forty_or_more_yards_each')">
                    <abbr title="Rushing 40+ Yards Each">40+</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>

                <th width="6.0%">
                  <a @click="setSort('rushing_fumbles')" :class="isActive('rushing_fumbles')">
                    <abbr title="Rushing Fumbles">FUM</abbr>
                    <i class="fas fa-sort-numeric-down" v-if="sortDirection === 'ASC'"></i>
                    <i class="fas fa-sort-numeric-up" v-else></i>
                  </a>
                </th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="player in players" :key="player.id">
                <td>{{player.player}}</td>
                <td>{{player.team}}</td>
                <td>{{player.position}}</td>
                <td>{{player.rushing_attempts_per_game}}</td>
                <td>{{player.rushing_attempts}}</td>
                <td>{{player.total_rushing_yards}}</td>
                <td>{{player.rushing_average_yards_per_attempt}}</td>
                <td>{{player.rushing_yards_per_game}}</td>
                <td>{{player.touchdowns}}</td>
                <td>{{player.longest_rush}}</td>
                <td>{{player.rushing_first_downs}}</td>
                <td>{{player.rushing_first_down_percentage}}</td>
                <td>{{player.rushing_twenty_or_more_yards_each}}</td>
                <td>{{player.rushing_forty_or_more_yards_each}}</td>
                <td>{{player.rushing_fumbles}}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <Pagination :current_page="meta.current_page" :pages="meta.total_pages"/>
      </div>

      <div v-else>
        <article class="message is-primary">
          <div class="message-body">
            No players
          </div>
        </article>
      </div>
    </div>
  </section>
</template>

<script>
const axios = require('axios')

import Pagination from './pagination'

export default {
  name: 'Players',

  components: {
    Pagination
  },

  data () {
    return {
      page: 1,
      playerFilter: '',
      players: [],
      meta: null,
      sort: 'player',
      sortDirection: 'ASC'
    }
  },

  // updates the table when these attributes change
  watch: {
    sort: function (sort) {
      this.fetchPlayers(sort, this.sortDirection, this.page, this.playerFilter)
    },

    page: function (page) {
      this.fetchPlayers(this.sort, this.sortDirection, page, this.playerFilter)
    },

    sortDirection: function (sortDirection) {
      this.fetchPlayers(this.sort, sortDirection, this.page, this.playerFilter)
    },

    playerFilter: function(filter) {
      this.fetchPlayers(this.sort, this.sortDirection, this.page, filter)
    }
  },

  methods: {
    setSort(column) {
      // toggle direction if clicked again
      if (this.sort === column) {
        this.toggleSortDirection()
      } else {
        // set sorting attribute
        this.sort = column
        this.sortDirection = 'ASC'
      }
    },

    isActive(column) {
      if (column === this.sort) {
        return 'is-active'
      } else {
        return ''
      }
    },

    toggleSortDirection() {
      if (this.sortDirection === 'ASC') {
        this.sortDirection = 'DESC'
      } else {
        this.sortDirection = 'ASC'
      }
    },

    fetchPlayers(sort, sortDirection, page, filter) {
      let query
      if (sort.length > 0) {
        query = `/api/v1/players?sort=${encodeURIComponent(sort)}&sort_direction=${encodeURIComponent(sortDirection)}&page=${encodeURIComponent(page)}&filter=${encodeURIComponent(filter)}`
      } else {
        query = `/api/v1/players?page=${encodeURIComponent(page)}&filter=${encodeURIComponent(filter)}`
      }
      axios.get(query)
        .then(response => response.data)
        .then(data => {
          this.players = data.players
          this.meta = data.meta
        })
    },

    downloadCSV(sort, sortDirection, page, filter) {
      let query
      if (sort.length > 0) {
        query = `/api/v1/players.csv?sort=${encodeURIComponent(sort)}&sort_direction=${encodeURIComponent(sortDirection)}&page=${encodeURIComponent(page)}&filter=${encodeURIComponent(filter)}`
      } else {
        query = `/api/v1/players.csv?page=${encodeURIComponent(page)}&filter=${encodeURIComponent(filter)}`
      }
      window.open(query)
    }
  },

  // populate the table with default parameters on page load
  mounted () {
    this.fetchPlayers(this.sort, this.sortDirection, this.page, this.playerFilter)
  }
}
</script>

<style lang="scss" scoped>
p {
  font-size: 2em;
  text-align: center;
}

.message {
  margin: 6.5rem;
}

th {
  background-color: Silver;

  & > a {
    white-space: nowrap;

    &.is-active {
      color: NavajoWhite;
    }
  }
}
</style>
