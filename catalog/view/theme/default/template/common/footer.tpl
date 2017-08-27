</div>
<footer>
    <div class="container">
        <div class="row">
            <div class="col-sm-4 first">
                <h5><a href="<?php echo $blog; ?>"><?php echo $text_read_our_blog; ?></a></h5>
				<div class="purchaseIcons">
                    <img src="catalog/view/theme/default/image/gopay_bannery-modre.png">
                    <img src="catalog/view/theme/default/image/pay/pay5.png">
                    <img src="catalog/view/theme/default/image/pay/pay6.png">
                    <img src="catalog/view/theme/default/image/pay/pay7.png">
                    <div class="clear"></div>
                    <img src="catalog/view/theme/default/image/pay/pay4.png">
                    <img class="big" src="catalog/view/theme/default/image/pay/pay1.png">
                    <img class="big" src="catalog/view/theme/default/image/pay/pay2.png">
                    <img class="big" src="catalog/view/theme/default/image/pay/pay3.png">

                </div>
            </div>
            <div class="col-sm-4 text-center">
                <div class="annabelle"><?php echo $text_call_for_order; ?></div>
                <div class="topPhone">
                    <div class="phone"><?php echo $telephone; ?></div>
                </div>
                <div class="socLinks">
                    <?php foreach ($soc_icons as $soc => $link) { ?>
                        <div>
                            <a href="<?php echo $link; ?>" target="_blank">
                                <img src="catalog/view/theme/default/image/<?php echo $soc; ?>.png"
                                     alt="<?php echo ${"title_soc_$soc"}; ?>"
                                     title="<?php echo ${"title_soc_$soc"}; ?>"/>
                            </a>
                        </div>
                    <?php } ?>
                </div>
                <p class="powered"><?php echo $powered; ?></p>
            </div>
            <div class="col-sm-4 third">
                <?php foreach ($modules as $module) { ?>
                    <?php echo $module; ?>
                <?php } ?>
            </div>
        </div>
    </div>
</footer>





        <div id="top_up" style="display: none;"><i class="fa fa-chevron-up" aria-hidden="true"></i></div>
    <script type="text/javascript">
            var top_show = 350; // В каком положении полосы прокрутки начинать показ кнопки "Наверх"
            var delay = 1000; // Задержка прокрутки
            $(document).ready(function () {
                $(window).scroll(function () { // При прокрутке попадаем в эту функцию
                    /* В зависимости от положения полосы прокрукти и значения top_show, скрываем или открываем кнопку "Наверх" */
                    if ($(this).scrollTop() > top_show)
                        $('#top_up').fadeIn();
                    else
                        $('#top_up').fadeOut();
                });
                $('#top_up').click(function () { // При клике по кнопке "Наверх" попадаем в эту функцию
                    /* Плавная прокрутка наверх */
                    $('body, html').animate({
                        scrollTop: 0
                    }, delay);
                });
            });
    </script>

</body>
</html>