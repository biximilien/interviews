$(document).ready(function() {
  updatePokes();
})

function updatePokes(form, page = 1) {
  if (event) {
    event.preventDefault();
  }

  var q = $('input[name="q"]').val();
  var tbody = $('table#pokemons-table > tbody');

  if (q === "") {
    $.ajax({
      url: '/api/pokemons',
      data: { page: page },
      success: (data, status, xhr) => {
        $(document).data('page', page);
        tbody.empty()
        data.pokemons.forEach((pokemon) => { appendPokemon(tbody, pokemon) });
        renderPagination(data.meta);
      }
    });
  } else {
    $.ajax({
      url: '/api/pokemons',
      data: { q: q, page: page },
      success: (data, status, xhr) => {
        $(document).data('q', q);
        $(document).data('page', page);
        tbody.empty()
        data.pokemons.forEach((pokemon) => { appendPokemon(tbody, pokemon) });
        renderPagination(data.meta);
      }
    });
  }
}

function appendPokemon(tbody, pokemon) {
  tbody.append(`
    <tr id="pokemon-row-${pokemon.id}" data-pokemon-id="${pokemon.id}">
      <td>${pokemon.number}</td>
      <td>${pokemon.name}</td>
      <td>${pokemon.type_1}</td>
      <td>${pokemon.type_2 == null ? '' : pokemon.type_2}</td>
      <td>${pokemon.total}</td>
      <td>${pokemon.hp}</td>
      <td>${pokemon.attack}</td>
      <td>${pokemon.defense}</td>
      <td>${pokemon.sp_atk}</td>
      <td>${pokemon.sp_def}</td>
      <td>${pokemon.speed}</td>
      <td>${pokemon.generation}</td>
      <td>${pokemon.legendary == true ? 'Yes' : 'No'}</td>
      <td>
        <form onsubmit="deletePoke(this)">
          <input type="submit" value="Delete" class="button is-danger is-small">
        </form>
      </td>
    </tr>
  `);
}

function createPoke(form) {
  if (event) {
    event.preventDefault();
  }

  var tbody = $('table#pokemons-table > tbody');

  $.ajax({
    url: '/api/pokemons',
    method: 'post',
    data: pokemonFormData(),
    success: (data, status, xhr) => { appendPokemon(tbody, data); form.reset() },
    error: (xhr, status, err) => { console.log(err) }
  });
}

function pokemonFormData() {
  return {
    'pokemon[number]': $('input[name="pokemon[number]"]').val(),
    'pokemon[name]': $('input[name="pokemon[name]"]').val(),
    'pokemon[type_1]': $('input[name="pokemon[type_1]"]').val(),
    'pokemon[type_2]': $('input[name="pokemon[type_2]"]').val(),
    'pokemon[total]': $('input[name="pokemon[total]"]').val(),
    'pokemon[hp]': $('input[name="pokemon[hp]"]').val(),
    'pokemon[attack]': $('input[name="pokemon[attack]"]').val(),
    'pokemon[defense]': $('input[name="pokemon[defense]"]').val(),
    'pokemon[sp_atk]': $('input[name="pokemon[sp_atk]"]').val(),
    'pokemon[sp_def]': $('input[name="pokemon[sp_def]"]').val(),
    'pokemon[speed]': $('input[name="pokemon[speed]"]').val(),
    'pokemon[generation]': $('input[name="pokemon[generation]"]').val(),
    'pokemon[legendary]': $('input[name="pokemon[legendary]"]').val()
  }
}

function deletePoke(form) {
  if (event) {
    event.preventDefault();
  }

  var $row = $(form).parent('td').parent('tr');
  var pokemonId = $row.data('pokemon-id');

  $.ajax({
    url: `/api/pokemons/${pokemonId}`,
    method: 'delete',
    success: (data, status, xhr) => { $row.remove() },
    error: (xhr, status, err) => { console.log(err) }
  });
}

function goToPage(page) {
  if (page == null) return;
  updatePokes(null, page);
}

function renderPagination(meta) {
  var total_pages = meta.total_pages;
  var current_page = meta.current_page;
  var next_page = meta.next_page;
  var prev_page = meta.prev_page;

  var pagination = `
    <nav class="pagination is-rounded" role="navigation" aria-label="pagination">
      <a class="pagination-previous" onclick="goToPage(${prev_page})">Previous</a>
      <a class="pagination-next" onclick="goToPage(${next_page})">Next page</a>
      <ul class="pagination-list">
  `;

  for (var i = 1; i <= total_pages; i++) {
    pagination += `<li><a class="pagination-link ${i == current_page ? 'is-current' : ''}" aria-label="Goto page ${i}" onclick="goToPage(${i})">${i}</a></li>`;
  }

  pagination += "</ul></nav>";

  $('#pagination-box > nav').replaceWith(pagination);
}
