$(document).ready(function() {

  $("#ingredient_id").select2({
      tokenSeparators: [',', ' '],
      minimumInputLength: 2,
      placeholder: "Start typing your ingredient",
      ajax: {
          url: '/ingredients',
          dataType: "json",
          type: "GET",
          data: function (params) {

              var queryParameters = {
                  term: params.term
              }
              return queryParameters;
          },
          processResults: function (data) {
              return {
                  results: $.map(data, function (item) {
                      return {
                          text: item.name,
                          id: item.id
                      }
                  })
              };
          }
      }
  });
});
