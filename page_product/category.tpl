
<?php
global $loader, $registry;
$loader->model('module/kolesadpua');
$model_kolesadpua = $registry->get('model_module_kolesadpua');
?>
<?php echo $header; ?>
<!-- main area begin -->
<style>
/*
    Не пугайся, не ругайся)
    По google page speed была очень низкая скорость 
    загрузки страници товаров (категории) 54 мобильный \ 44 ПК
    В основном такая низкая оценка из-за медленного ответа сервера
    Я подозреваю что скрипт слишком тяжелый, долго тянутся товары из базы.
    На данный момент (24.07.2018) в базе ~ 32000 товаров, как Я знаю opencart 
    плохо справляется с >10000 товаров. 
    
    Что-бы хоть как-то исправить ситуацию для мобильной версии
    Я вставил стили для каточек товара, и фильтров сразу в разметку 
    так первый экран быстрее формируется. 
    Оценка page speed  поднялась на 15 пунктов.


    Ранее Я в GRUNT резал файлы стилей для первого экрана каждой страници
    и выводил через условие, так оценка становилось максимальной ~ 95\100
    Но правки по front-end проискходят регулярно, от этого метода пришлось отказатся. 

    Если сейчас ситуация позволяет то используй Grunt unss

*/ 
/*Свойства для карточки товара*/
.button_searsh_in_filter{
    display: none;
}
.content-category-container-column-orders-row{
    display: none;
}
.content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-header-category-pagination-row .content-category-container-column-header-category-pagination-column .pagination > li > a{
    padding-right: 9px;
    padding-left: 9px;
    font-size: 1.2em;
}

@media screen and  (max-width: 767px){
    .container_sort .filter__close{
        display: inline;
        position: absolute;
        right: 6%;
        top: 7%;
        font-size: 2em;
        padding: 10px;
    }
    .grid_column{
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }
    .product_column{
        width: 47%;
    }
    .product_column:first-child{
        position: relative;
        left: -3%;
    }
    .product_column:last-child{
        position: relative;
        right: -3%;
    }
    .button_colomn{
        width: 90% !important;
    }
    .content-category-container-column-product-wrap-item{
        padding: 0 !important;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap{
        box-shadow: 0 0 16px 1px #484848;
        border-radius: 4px;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-name-vertical-container{
        text-align: center;
        height: auto;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-season-vertical-container{
        position: absolute;
        top: 5%;
        left: 5%;
        width: auto;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-season-vertical-container .content-category-container-column-product-wrap-item-season-gorizontal-container .content-category-container-column-product-wrap-item-season-symbol i{
        font-size: 2em;
        /* color: #ed494e !important; */
    }
    .container-review a{
        display: block;
        width: 40%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #ed4f3d;
        border-radius: 4px;
        font-size: 1.4em;
        color: #ed4f3d;
        font-weight: 500;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-buy-vertical-container .content-category-container-column-product-wrap-item-buy-gorizontal-container .content-category-container-column-product-wrap-item-buy-price .new-price{
        width: 100%;
        text-align: center;
        font-weight: 400;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-buy-vertical-container .content-category-container-column-product-wrap-item-buy-gorizontal-container .content-category-container-column-product-wrap-item-buy-button{
        float: none;
        margin: 0 auto;
        display: block;
        width: 41%;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-buy-vertical-container .content-category-container-column-product-wrap-item-buy-gorizontal-container .content-category-container-column-product-wrap-item-buy-button .button-buy-from-category{
        height: auto;
        font-size: 1.5em;
        border-radius: 5px;
        padding: 0;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product{
        padding: 0 0 10px 0;
        margin: 0 0 10px 0;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap:hover{
        border: 2px solid transparent !important;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-vertical-container{
        background-size: 216%;
        background-position: 38% -47%;
        background-repeat: no-repeat;
        border: 1px solid #c3c3c3;
        height: 53%;
        max-height: 100%;
        border: none;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item{
        height: 38vh;
        position: relative;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-buy-vertical-container .content-category-container-column-product-wrap-item-buy-gorizontal-container .content-category-container-column-product-wrap-item-buy-price{
        display: block;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-buy-vertical-container{
        position: absolute;
        bottom: 5px;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-buy-vertical-container .content-category-container-column-product-wrap-item-buy-gorizontal-container .content-category-container-column-product-wrap-item-buy-price .new-price{
        font-size: 1.6em;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-name-vertical-container{
        font-size: 1.3em;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-vertical-container .content-category-container-column-product-wrap-item-gorizontal-container{
        width: 100%;
        max-width: 100%;
        margin-right: 0;
        margin-left: 0;
        height: 100%;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-vertical-container .content-category-container-column-product-wrap-item-gorizontal-container .content-category-container-column-product-wrap-item-link .content-category-container-column-product-wrap-item-img{
        height: 300%;
        transform: translate(20px, 133px);
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-vertical-container .content-category-container-column-product-wrap-item-gorizontal-container .content-category-container-column-product-wrap-item-link{
        width: 100%;
        height: 90%;
    }
/*Закончились стили для карточки товара*/

/* Стили для фильтра по параметрам шины */
    section.content-category .content-category-container-column-filter{
        position: absolute;
        width: 100%;
        background: #fff;
        z-index: 1;
        height: 100vh;
        top: 85px;
        padding: 0;
    }
/* Закончились стили для фильтра по параметрам шины */

/* Стили для кнопки сколько товаров отображать на странице*/ 
    .content-category-container-column-orders-row-column-showcount{
        display: none;
    }
/* Закончились стили для кнопки сколько товаров отображать на странице*/ 


/* Стили для кнопки сортировка */
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-orders-row .content-category-container-column-orders-row-column-sort .content-category-selector-order .btn-default{
        border: none !important;
    }
/* Закончились стили для кнопки сортировка */ 

/*общиие стили для таблицы с кнопками фильтров*/ 
    #table_filter tr td a{
        displaytable_filter_trIco: block;
        width: 100%;
        text-align: center;
        color: #ed494e;
    }
    #table_filter tr td .fa{
        color: #ed494e;
    }
/* Закончились общиие стили для таблицы с кнопками фильтров*/ 

/* Стили для фильтра сортировки по ценам */
    .container_sort {
        position: fixed;
        width: 100%;
        height: 100vh;
        background: linear-gradient(-1deg, rgba(0, 0, 0, 0.75) 30%, rgba(234, 234, 234, 0.81) 70%);
        padding: 30% 0 0 0;
        z-index: 1;
        right: -100%;
        /* transition: all 0.6s cubic-bezier(0.4, 0, 1, 1); */
        transition: all 0.4s;
    }
    .container_sort a{
        width: 80%;
        display: block;
        text-align: center;
        margin: 40px auto 0 auto;
        background: #fff;
        height: 60px;
        border-radius: 18px;
        line-height: 60px;
        border: 1px solid #ed494e;
        color: #000;
        font-size: 1.4em;
        display: none;
    }
    .container_sort a:nth-child(5),
    .container_sort a:nth-child(6){
        display: block;
    }
    .show_sort{
        right: 0;
    }
    #table_filter{
        position: fixed;
        z-index: 10;
        background: #fff;
        top: 38px;
        height: 53px;
        box-shadow: 0 0 10px #000;
        width: 100%;
    }
    #table_filter td {
        padding: 0 10px;
        text-align: center;
        /* width: 33.333333333%; */
    }
    .show_filter{
        left: 0 !important;
    }
/* Закончились стили для фильтра сортировки по ценам */

/*
    общие стили для панели фильтров 
*/ 

    #table_filter td  .fa{
        font-size: 2.2em;
    }

/* Стили для заголвока страницы*/ 
    .content-category .content-category-container .content-category-container-row .content-category-container-column-header-category .text-content{
        width: 100%;
    }
    .text-content h1{
        width: 100%;
        text-align: center;
        padding: 10px 0 0 0;
    }
    /* Стили для отображения карточек в виде списка */
    .container_list_wrap{
        margin: 0 0 -10px 0 !important;
    }
    .container_list{
        box-shadow: 0 0 12px 1px #999 !important;
        border-radius: 2px !important;
    }
    .container_list 
    .content-category-container-column-product-wrap-item{
        display: flex !important;
        justify-content: space-between !important;
        flex-wrap: nowrap !important;
        height: 9vh !important;
    }
    .container_list 
    .content-category-container-column-product-wrap-item-vertical-container{
        width: 18% !important;
        height: auto !important;
    }
    .container_list 
    .content-category-container-column-product-wrap-item-season-vertical-container{
        top: auto !important;
        left: 22% !important;
        bottom: -14% !important;
    }
    .container_list 
    .content-category-container-column-product-wrap-item-name-vertical-container{
        font-size: 1em !important;
        width: max-content !important;
    }
    .container_list 
    .content-category-container-column-product-wrap-item-buy-vertical-container{
        width: auto !important;
        position: absolute !important;
        bottom: 5% !important;
        right: 5% !important;
    }
    .container_list 
    .content-category-container-column-product-wrap-item-buy-vertical-container 
    .content-category-container-column-product-wrap-item-buy-button{
        display: none !important;
    }
    .container_list 
    .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-vertical-container .content-category-container-column-product-wrap-item-gorizontal-container .content-category-container-column-product-wrap-item-link .content-category-container-column-product-wrap-item-img{
        height: 170% !important;
        transform: translate(5px, 22px) !important;
    }
    .container_list .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-buy-vertical-container .content-category-container-column-product-wrap-item-buy-gorizontal-container .content-category-container-column-product-wrap-item-buy-price .new-price{
        font-size: 1em !important;
        font-weight: 900 !important;
        color: #ec494e !important;
    }
    .container_list .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-season-vertical-container .content-category-container-column-product-wrap-item-season-gorizontal-container .content-category-container-column-product-wrap-item-season-symbol i{
        font-size: 1em !important;
    }
    .amountCart_on_page{
        background: #ed494e;
        padding: 0.4em 0;
        border-color: #ed494e;
        color: #ffffff;
        font-weight: 900;
        border-radius: 8px;
    }
    #table_filter_trIco td{
        padding: 10px 0 0 0;
    }

    tr#table_filter_trText td {
        font-size: 0.6em;
        color: #545454;
    }
    
}
@media screen and (max-width: 375px){
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item{
        height: 52vh;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-vertical-container .content-category-container-column-product-wrap-item-gorizontal-container .content-category-container-column-product-wrap-item-link .content-category-container-column-product-wrap-item-img{
        height: 200%;
    }
}
@media screen and (max-width: 340px){
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-name-vertical-container{
        font-size: 1em;
    }
}
@media screen and (max-width: 900px) and (orientation:landscape){
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item{
        height: 52vw;
    }
    .container_list 
    .content-category-container-column-product-wrap-item{
      
        height: 9vw !important;
    }
}
@media screen and (min-width: 380px) and (max-width: 766px){
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-name-vertical-container{
        font-size: 1em;
    }
}
@media screen and (min-width: 340px) and (max-width: 766px){
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-season-vertical-container {
        position: absolute;
        top: 1%;
        left: 1%;
        width: auto;
    }
    .content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-season-vertical-container .content-category-container-column-product-wrap-item-season-gorizontal-container .content-category-container-column-product-wrap-item-season-symbol i{
        font-size: 1em;
    }
}
</style>
<style>
.content-category .content-category-container .content-category-container-row .content-category-container-column-products .content-category-container-column-products-row .content-category-container-column-product .content-category-container-column-product-wrap .content-category-container-column-product-wrap-item .content-category-container-column-product-wrap-item-vertical-container .content-category-container-column-product-wrap-item-gorizontal-container .content-category-container-column-product-wrap-item-link .content-category-container-column-product-wrap-item-img{
    transform: scale(2.2) translate(8%, 27%);
}
</style>
<main role="main" class="under-header">
<table id="table_filter">
    <tr id="table_filter_trIco">
        <td onclick="open_filter()" >
            <span>
                <i class="fa fa-cog fa-spin" aria-hidden="true"></i>
            </span>
        </td>
        <td onclick="open_sort()" >
            <span>
                <i class="fa fa-exchange" aria-hidden="true"></i>
            </span> 
        </td>
        <td>
            <select class="amountCart_on_page" onchange="location = this.value;">
                <?php foreach ($limits as $limitss) { ?>
                        <?php if ($limitss['value'] == $limit) { ?>
                        <option value="<?php echo $limitss['href']; ?>" selected="selected" ><?php echo $limitss['text']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $limitss['href']; ?>"><?php echo $limitss['text']; ?></option>
                <?php } ?>
                <?php } ?>
            </select>
        </td>
        <td onclick="grid_colum()">
            <span>
                <i class="fa fa-th-large" aria-hidden="true"></i>
            </span>
        </td>
        <td onclick="grid_list()">
            <span>
                <i class="fa fa-list-alt" aria-hidden="true"></i>
            </span>
        </td>
        <!-- <td>
            <a href="#open_filter">
                Сбросить фильтр
            </a>
        </td> -->
    </tr>
    <tr id="table_filter_trText">
        <td>Фильтр      </td>
        <td>Сортировать </td>
        <td>Показывать  </td>
        <td>Ячейки      </td>
        <td>Список      </td>
    </tr>
</table>  
    <section class="content-category">
        <div class="container_sort">

            <span class="filter__close"  onclick="close_sort()" >
                <i class="fa fa-times" aria-hidden="true"></i>
            </span>
        
            <?php foreach ($sorts as $sortss) {
                if(in_array($sortss['value'], array('p.price-ASC', 'p.price-DESC', 'pd.name-ASC', 'pd.name-DESC', 'p.sort_order-ASC'))) {
            ?>
                    <?php if ($sortss['value'] == $sort . '-' . $order) { ?>
                    <a href="<?php echo $sortss['href']; ?>">
                        <?php echo $sortss['text']; ?>
                    </a>
                    <?php } else { ?>
                    <a href="<?php echo $sortss['href']; ?>">
                        <?php echo $sortss['text']; ?>
                    </a>
                <?php } ?>
            <?php } ?>
            <?php } ?>
        </div>
        <div class="content-category-container"  >


            <div class="content-category-container-row">
                <div class="content-category-container-column-header-category">


                   <div class="content-category-container-column-header-category-breacrumbs"  itemscope itemtype="http://schema.org/BreadcrumbList">
                        <?php for ($i=0; $i<count($breadcrumbs)-1;$i++) { ?>
                        <span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                            <a itemprop="item" href="<?php echo $breadcrumbs[$i]['href']; ?>">
                                <span itemprop="name"><?php echo $breadcrumbs[$i]['text']; ?>
                                </span>
                            </a>
                             <meta itemprop="position" content="<?php if($i==0) echo 1; else echo $i; ?>" />
                        </span>
                        <?php } ?>
                        <span itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                            <a itemprop="item" href="<?php echo $breadcrumbs[count($breadcrumbs)-1]['href']; ?>" class="last">
                                <span itemprop="name"><?php echo $breadcrumbs[count($breadcrumbs)-1]['text']; ?></span>
                            </a>
                            <meta itemprop="position" content="<?php if($i==0) echo 1; else echo $i; ?>" />
                        </span>
                    </div>


                    <div class="text-content">
                        <h1 itemprop="Name"><?php echo $heading_title; ?></h1>
                    </div>
                </div>
            </div>
            <div class="content-category-container-row" >


               <?php echo $column_left; ?>

                <div class="content-category-container-column-products">
                    <?php echo $content_top; ?>
                    <div class="content-category-container-column-orders-row">
						<div class="content-category-container-column-orders-row-column-sort">
                           
						</div>
						<div class="content-category-container-column-orders-row-column-showcount">
							<span class="orders-header">
								На странице:
							</span>
							<div class="content-category-selector-showcount">
								<select class="form-control selector_showcount_category" onchange="location = this.value;">
									<?php foreach ($limits as $limitss) { ?>
											<?php if ($limitss['value'] == $limit) { ?>
											<option value="<?php echo $limitss['href']; ?>" selected="selected" ><?php echo $limitss['text']; ?></option>
											<?php } else { ?>
											<option value="<?php echo $limitss['href']; ?>"><?php echo $limitss['text']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
							</div>
						</div>
                    </div>
                    <div class="content-category-container-column-products-row grid_column">
                    <!--[quantity] => 16
                        [product_id] => 100000149889000000
                        [thumb] => https://www.mobilshina.com.ua/image/data/tracmax_x-privilo-tx2.jpg
                        [name] => 135/70 R15 TRACMAX X-privilo TX2 70T
                        [description] => ..
                        [price] => 762грн.
                        [special] => 
                        [tax] => 762грн.
                        [minimum] => 1
                        [rating] => 5
                        [href] => http://localhost/index.php?route=product/product&path=_59&product_id=100000149889000000 -->
                        <style>
                            .wrap-product{
                                height: 360px;
                                padding: 5px 5px;
                            }
                            .wrap-product > div{
                                height: 100%;
                            }
                            .wrap-product > div .wrap-img{
                                height: 45%;
                                overflow: hidden;
                                border: 1px solid #8888882b;;
                                position: relative;
                                margin: 0 0 10px 0;
                                display: block;
                            }
                            .wrap-product > div .wrap-img i{
                                position: absolute;
                                top: 2%;
                                left: 1%;
                                font-size: 2.3em;
                                color: #ff9108;
                            }
                            .wrap-product > div .wrap-img i.special-icon-winter {
                                color: #34b1ff;
                            }
                            .wrap-product > div .wrap-img .special-icon-all-season:after {
                                color: #34b1ff;
                            }
                            .wrap-product > div .wrap-img .special-icon-all-season:before {
                                color: #ff9108;
                            }
                            .wrap-product > div .wrap-img img{
                                vertical-align: middle;
                                height: 400px;
                                display: block;
                                margin: 0 auto;
                                transform: translate(-23%, 10%);    
                            }
                            @media screen and (max-width: 991px){
                                .wrap-product > div .wrap-img img{
                                    transform: translate(-3%, 10%);
                                }
                            }
                            @media screen and (max-width: 450px){
                                .wrap-product > div .wrap-img img {
                                    transform: translate(-10%, 10%);
                                }
                            }
                            @media screen and (max-width: 400px){
                                .wrap-product > div .wrap-img img {
                                    transform: translate(-16%, 10%);
                                }
                            }
                            .wrap-product > div .product_size{
                                width: 100%;
                                display: block;
                                text-align: center;
                                font-size: 1.2em;
                                color: #444;
                            }
                            .wrap-product .product_price{
                                width: 100%;
                                margin: 3px 0;
                                font-size: 1.2em;
                            }
                            .wrap-product .product_price td{
                                text-align: center;
                                width: 33.33333%;
                            }
                            .wrap-product .product_review {
                                border: 1px solid #f00;
                                padding: 2px 10px;
                                border-radius: 6px;
                                margin: 0 auto;
                                width: max-content;
                                display: block;
                                color: #f00;
                            }
                            .wrap-product .product_name{
                                margin: 0 0 5px 0;
                                font-size: 1.4em;
                                font-weight: 400;
                                color: #000;
                                width: 100%;
                                display: block;
                            }
                            .wrap-product .product_name:hover{
                                text-decoration: none;
                            }
                            .wrap-product > div .product_buy{
                                color: #fff;
                                background: #f00;
                                font-size: 1.6em;
                                font-weight: 500;
                                padding: 1px 20px;
                                border-radius: 10px;
                                width: max-content;
                                display: block;
                                margin: 0 auto;
                            }
                            .wrap-product > div .product_buy:hover{
                                text-decoration: none;
                            }
                        </style>
                        <?php foreach ($products as $product) { ?>
                           <div class="col-xs-12 col-lg-3 col-md-4 col-sm-6  wrap-product">
                                <div>
                                    <a href="<?php echo $product['href'] ?>" class="wrap-img">
                                        <img src="<?php  echo $product['thumb']?>" alt="<?php echo $product['name']?>" title="<?php echo $product['name']?>">
                                        <?php
                                            switch ((int)$model_kolesadpua->getSeason($product['product_id'], $path))
                                            {
                                                case 1:
                                                {
                                                    echo '<i class="special-icon-winter"></i>';
                                                    break;
                                                }
                                                case 2:
                                                {
                                                    echo '<i class="special-icon-sun"></i>';
                                                    break;
                                                }
                                                case 3:
                                                {
                                                    echo '<i class="special-icon-all-season"></i>';
                                                    break;
                                                }
                                            }
                                        ?>
                                    </a>
                                        <span class="product_size">
                                            140/60 R14
                                        </span>
                                    <a href="<?php echo $product['href']?>" class="text-center product_name">
                                        MICHELIN Compact 65T
                                    </a>
                                    <span class="product_review">
                                        Отзывы (0)
                                    </span>
                                    <!-- <table class="product_price">
                                        <thead>
                                            <tr>
                                                <td>
                                                    от 1345 грн
                                                </td>
                                                <td>
                                                    до
                                                </td>
                                                <td>
                                                    1918 грн
                                                </td>
                                            </tr>
                                        </thead>
                                    </table> -->
                                    <p class="text-center product_price">
                                        от 1995 грн до 2490 грн
                                    </p>
                                    <a class="product_buy" href="<?php echo $product['href']?>">
                                        Купить
                                    </a>
                                </div>
                           </div>
                        <?php } ?>
                    </div>
                    <div class="content-category-container-column-header-category-pagination-row">

                        <div class="content-category-container-column-orders-row-column-sort visible-lg">
                            <div class="content-category-selector-order">
                                <select class="form-control selector_order_category" onchange="location = this.value;">
                                    <?php foreach ($sorts as $sortss) {
										if(in_array($sortss['value'], array('p.price-ASC', 'p.price-DESC', 'pd.name-ASC', 'pd.name-DESC', 'p.sort_order-ASC'))) {
									?>
                                    <?php if ($sortss['value'] == $sort . '-' . $order) { ?>
                                    <option value="<?php echo $sortss['href']; ?>" selected="selected"><?php echo $sortss['text']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $sortss['href']; ?>"><?php echo $sortss['text']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>



                        <div class="content-category-container-column-orders-row-column-showcount">

                            <div class="content-category-selector-showcount">
                                <select class="form-control selector_showcount_category" onchange="location = this.value;">
                                    <?php foreach ($limits as $limitss) { ?>
                                    <?php if ($limitss['value'] == $limit) { ?>
                                    <option value="<?php echo $limitss['href']; ?>" selected="selected"><?php echo $limitss['text']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $limitss['href']; ?>"><?php echo $limitss['text']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>

                        <div class="content-category-container-column-header-category-pagination-column">
                            <div class="links">
                                <?php echo $pagination; ?>
                                <!-- <a href="#" class="pagination_a_page_prev_next"><</a>
                                <a href="#" class="pagination_a">1</a>
                                <a href="#" class="pagination_a">2</a>
                                <a href="#" class="pagination_a">3</a>
                                <a href="#" class="pagination_a">4</a>
                                <a href="#" class="pagination_a">5</a>
                                <b>6</b>
                                <a href="#" class="pagination_a">7</a>
                                <a href="#" class="pagination_a">8</a>
                                <a href="#" class="pagination_a">9</a>
                                <a href="#" class="pagination_a">10</a>
                                <a href="#" class="pagination_a_page_prev_next">></a>  -->
                            </div>
                        </div>
                    </div>

                    <div class="text-content"><?php echo $description; ?></div>
                    <?php echo $content_bottom; ?>
                </div>
            </div>
        </div>
    </section>
</main>
<!-- main area end -->
<?php echo $footer; ?>