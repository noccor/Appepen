$(document).ready(function() {

  $("#banana").select2({
      tokenSeparators: [',', ' '],
      minimumInputLength: 2,
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
