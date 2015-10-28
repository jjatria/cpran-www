<!DOCTYPE html>
<?php
	//ini_set('display_errors', 'On');
	//error_reporting(E_ALL | E_STRICT);
?>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<?php
		$LANG = substr($_GET["lang"], 0, 2);
		$SID = $_GET["sid"];
		switch ($LANG) {
		case 'es':
			$TITLE = "Gracias por participar";
			$NAMELABEL = "Nombre";
			$MAILLABEL = "E-mail";
			$SAMPLENAME = "Juan Pérez";
			$SAMPLEMAIL = "ejemplo@dominio.com";
			$SUBMITLABEL = "Enviar";
			break;
		case 'ja':
			$TITLE = "ご強力ありがとうございました";
			$NAMELABEL = "名前";
			$MAILLABEL = "Eメール";
			$SAMPLENAME = "YAMADA Taro";
			$SAMPLEMAIL = "taro@home.ne.jp";
			$SUBMITLABEL = "送信";
			break;
		default:
			$TITLE = "Thank you for your participation";
			$NAMELABEL = "Name";
			$MAILLABEL = "E-mail";
			$SAMPLENAME = "John Doe";
			$SAMPLEMAIL = "email@example.com";
			$SUBMITLABEL = "Submit";
		}
		$SURVEYURL = "http://penguin.limequery.com/$SID/lang-" . $_GET["lang"];
	//  With LimeSurvey 2.00+ the survey URL has changed
	//  $SURVEYURL = "http://penguin.limequery.com/index.php/$SID/lang-$LANG";
		$SURVEYLINK = "<div class='surveylink'><a href='$SURVEYURL'>$SURVEYURL</a></div>\n\n";
		echo "<title>JJA | $TITLE</title>\n";
	?>
	<meta charset="utf-8" />
	<link rel="shortcut icon" href="http://ucl.ac.uk/~ucjt465/images/favicon.ico" />
	<link rel="stylesheet" href="http://ucl.ac.uk/~ucjt465/style.css" />
	<link rel="stylesheet" href="http://ucl.ac.uk/~ucjt465/forms.css" />
	<link rel="stylesheet" href="http://ucl.ac.uk/~ucjt465/linkbar.css" />
	<style>
		div.surveylink { text-align: center }
	</style>
</head>

<body class='thankyou'>

<div id="banner"><a href="http://ucl.ac.uk/~ucjt465/index.html">Home</a></div>

<nav id="linkbar">
<div id="topbar">
<ul>
		<li><a href="http://ucl.ac.uk/~ucjt465/research/index.html">Research</a></li>
		<li><a href="http://ucl.ac.uk/~ucjt465/tutorials/index.html">Tutorials</a></li>
		<li><a href="http://ucl.ac.uk/~ucjt465/scripts/index.html">Scripts</a></li>
</ul>
</div>
</nav>

<div class="content">

<?php
	switch ($LANG) {
		case 'es':
			echo "<h1 class='maintitle'>¡Muchas gracias!</h1>\n\n";

			echo "<p>Gracias por participar en mi estudio. Si sabes de otras personas\n".
			     "que podrían querer tomar la prueba, puedes invitarlos a que lo hagan\n".
			     "mandándoles este link:</p>\n\n";

			echo $SURVEYLINK;

			echo "<p>¡Y si me dejas tu correo electrónico podré contactarte una vez que\n".
			     "tenga los resultados definitivos, que de seguro serán interesantes!</p>\n\n";

			echo "<p>También puedes dejarme tus datos si es que te interesaría y estarías\n".
			     "dispuesto a ser contactado para las futuras etapas del estudio. Esto\n".
			     "también lo agradecería profundamente.</p>\n\n";

			echo "<p>Como este formulario y la prueba que acabas de tomar son completamente\n".
			     "independientes, <strong>no hay manera para mí de vincular tus respuestas a\n".
			     "tu nombre o correo electrónico</strong>, por lo que dejar aquí tu información\n".
			     "no pone en riesgo alguno la anonimidad de tus respuestas.</p>\n\n";

			echo "<p>Y como <strong>nadie detesta a los spammers más que yo</strong>, puedes\n".
			     "estar completamente seguro de que no recibirás de mí más que aquellos correos\n".
			     "que sean absolutamente necesarios.</p>\n\n";

			echo "<p>De nuevo, ¡muchas gracias!</p>\n\n";

			echo "<div class='rem'><p>Si por alguna razón llegaste a esta página sin haber\n".
			     "tomado la prueba, puedes <a href='$SURVEYURL'>\n".
			     "echarle un vistazo</a> para ver si es que se te aplica y si es que\n".
			     "estarías interesado en llenarla. Me sería de gran ayuda.</p></div>\n\n";
			break;
		case 'ja':
			echo "<h1 class='maintitle'>ありがとうございました！</h1>\n\n";

			echo "<p>ご協力ありがとうございました。ご友人、ご家族の方にもこの実験に参加して\n".
			     "していただけるよう、下のリンクを使って広めていただければ、大変ありがたく存じます。<p>\n\n";

			echo $SURVEYLINK;

			echo "<p>Eメールアドレスを教えていただければ、この研究調査全体が終了した際にご連絡を差し上げ、\n".
			     "ご報告をさせていただきます。今回の実験結果は大変興味深いものになると考えています。</p>\n\n";

			echo "<p>この研究で今後実施予定の実験にもご参加していただける場合にも、ぜひご連絡先をお教えください。\n".
			     "ご協力に心から感謝いたします。</p>\n\n";

			echo "<p>現在ご覧になっているフォームと実験の他の部分とは全く関連性がありませんので、<strong>実験\n".
			     "での回答と、ここに記入して頂くEメールアドレスとを照合することは不可能</strong>であり、回答の匿\n".
			     "名性は保たれます。</p>\n\n";

			echo "<p>ちなみに、<strong>私個人もスパムメールには困っており、同様の迷惑を皆さまにかけるようなこと\n".
			     "はするつもりがありません。絶対に必要な場合以外はメールをしないと約束します</strong>。</p>\n\n";

			echo "<div class='rem'><p>もし何かの手違いで、実験の前にこのページに来てしまった場合、\n".
			     "<a href='$SURVEYURL'>実験</a>に参加できるかぜひご一考下さい。</p></div>\n\n";
			break;
		default:
			echo "<h1 class='maintitle'>Thank you!</h1>\n";

			echo "<p>Thank you for taking part in my survey. If you wish, you can invite\n".
			     "other friends of yours to take the test as well by sending them this link:<p>\n\n";

			echo $SURVEYLINK;

			echo "<p>If you leave me your email address, I'll be able to contact you\n".
			     "once the study is completed. Results are sure to be interesting!</p>\n\n";

			echo "<p>You can also leave your contact information in case you want\n".
			     "to participate in the following stages of this research, which\n".
			     "I would appreciate greatly.</p>\n\n";

			echo "<p>Since this form and the rest of the survey are completely\n".
			     "unrelated, <strong>there is no way for me to link your responses to your\n".
			     "email account</strong>, so there is no concern over maintaining the anonymity\n".
			     "of your answers.</p>\n\n";

			echo "<p>And <strong>nobody hates spammers more than I do</strong>, so you can be certain\n".
			     "you won't be receiving any more email from me than absolutely necessary.</p>\n\n";

			echo "<p>Thanks again!</p>\n\n";

			echo "<div class='rem'><p>If for some reason you got here without taking the survey, you\n".
			     "might want to <a href='$SURVEYURL'>take a look at it</a> and see if you are eligible and\n".
			     "interested in answering it. I'd sure appreciate it!</p></div>\n\n";
	}
?>

<form id=contact action="submit.php" method="post">
	<fieldset>
		<ol>
			<li>
				<?php echo "<label for=name>$NAMELABEL</label>\n" ?>
				<?php echo "<input name=name type=text placeholder='$SAMPLENAME' required pattern='[a-zA-ZáéíóúüÁÉÍÓÚÜñÑ -]+'>\n" ?>
			</li>
			<li>
				<?php echo "<label for=email>$MAILLABEL</label>\n" ?>
				<?php echo "<input name=email type=email placeholder='$SAMPLEMAIL' required>\n" ?>
			</li>
			<li>
				<?php echo "<input class='hidden' name=lang type=text value='$LANG'>\n" ?>
				<?php echo "<input class='hidden' name=sid type=text value='$SID'>\n" ?>
			</li>
		</ol>
	</fieldset>
	<fieldset id="submitbutton">
		<?php echo "<button type=submit>$SUBMITLABEL</button>\n" ?>
	</fieldset>
</form>

<div class="date">
	<script type="text/javascript" src="http://ucl.ac.uk/~ucjt465/scripts/js/last_modified.js"></script>
</div>

</div>
</body>
</html>