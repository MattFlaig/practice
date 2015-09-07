(function(){
    var gems = [
        {
            name: 'Azurite',
            price: 2.95,
            canPurchase: true,
            soldOut: true
        },
        {
            name: 'Azurite',
            price: 2.95,
            canPurchase: true,
            soldOut: true
        }
    ];
    var app = angular.module('gemStore', []);

    app.controller('StoreController', function(){
        this.products = gems;
    });
})();