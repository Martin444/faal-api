import 'package:faal_new2/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoUs extends StatefulWidget {
  const InfoUs({Key? key}) : super(key: key);

  @override
  State<InfoUs> createState() => _InfoUsState();
}

class _InfoUsState extends State<InfoUs> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 100,
      child: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/logodisensa.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                '¿Quienes somos?',
                style: titleDetail,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'FAAL SRL es una empresa con el compromiso de satisfacer las necesidades de nuestros clientes brindando la mejor ecuación producto-precio-servicio. Con nuestra estructura sólida y adecuada, y con nuestro personal capacitado aspiramos cada día alcanzar y mejorar nuestros estándares de calidad y servicio; de esta manera recibir la confianza de nuestros clientes al elegirnos para acompañarlos a la hora de construir.',
                textAlign: TextAlign.justify,
                style: titleAppBar,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Iniciamos nuestra actividad en año 1993 en la ciudad de Tartagal, principalmente dedicándonos a la comercialización de madera de pino para construcción y carpintería. A poco de nuestro comienzo, y viendo las necesidades insatisfechas de la creciente demanda de materiales para la construcción, decidimos incorporar nuevos rubros a nuestra oferta convirtiéndonos en pocos años en líder en artículos de ferretería y construcción en la ciudad de Tartagal y el departamento San Martín.',
                textAlign: TextAlign.justify,
                style: titleAppBar,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'En 2002 inauguramos nuestra sede principal que cuenta con 2000 m2 para poder abastecer a la demanda del mercado pudiendo ofrecer stock y variedad de los principales productos y marcas. Lo que nos permite acompañar a nuestros clientes en todos los tipos y todas las etapas de la construcción domiciliaria, industrial, públicas y diferentes proyectos particulares que emprendan.',
                textAlign: TextAlign.justify,
                style: titleAppBar,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Durante nuestro crecimiento y posicionamiento como referente de corralones y ferreterías, se formalizo una alianza en el año 2006 con la RED DISENSA – HOLCIM. Esto nos permitió ser los representantes oficiales de cemento HOLCIM y de sus socios estratégicos en la industria de la construcción brindando stock con entrega inmediata en todo momento.',
                textAlign: TextAlign.justify,
                style: titleAppBar,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Actualmente nos renovamos con el mismo compromiso y seguridad que FAAL representa en diferentes redes tecnológicas para un mayor alcance, efectividad y respuesta a los intereses de las necesidades de los ciudadanos a la hora de construir!',
                textAlign: TextAlign.justify,
                style: titleAppBar,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
