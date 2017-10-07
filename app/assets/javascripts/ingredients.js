$("#recipe_name").select2({
    minimumInputLength: 2,
    tags: [],
    ajax: {
        url: '/ingredients.json',
        dataType: 'json',
        type: "GET",
        quietMillis: 50,
        data: function (term) {
            return {
                term: term
            };
        },
        results: function (data) {
            return {
                results: $.map(data, function (ingredient) {
                    return {
                        name: item.name,
                        desc: item.desc,
                        id: item.id
                    }
                })
            };
        }
    }
});
