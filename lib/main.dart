import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: Center(
          child: Container(
            width: 430,
            constraints: const BoxConstraints(maxHeight: 950),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 10))],
            ),
            clipBehavior: Clip.antiAlias,
            child: const CalendarioScreen(),
          ),
        ),
      ),
    );
  }
}

// Paleta
const Color kCrema = Color(0xFFF6EFE2);
const Color kVino = Color(0xFF5C1A3D);
const Color kVerde = Color(0xFF2F5233);
const Color kAmbar = Color(0xFFD98C3D);
const Color kCoral = Color(0xFFE0563F);
const Color kTexto = Color(0xFF3A2A2E);
const kSerif = 'Georgia';

class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({super.key});

  static const Map<String, Map<String, dynamic>> diasEspeciales = {
    '5': {'tipo': 'destacado', 'color': kVino},
    '21': {'tipo': 'destacado2', 'color': kVerde},
    '12': {'tipo': 'evento', 'color': kAmbar},
    '18': {'tipo': 'evento', 'color': kAmbar},
    '8': {'tipo': 'especial', 'color': kVerde},
    '13': {'tipo': 'especial', 'color': kVerde},
    '14': {'tipo': 'especial', 'color': kVerde},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCrema,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _header(),
                  const SizedBox(height: 14),
                  _chips(),
                  const SizedBox(height: 16),
                  _calendario(),
                  const SizedBox(height: 14),
                  _filaFechas(),
                  const SizedBox(height: 12),
                  _filaFraseEnfoque(),
                  const SizedBox(height: 12),
                  _filaEventos(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          _bottomNav(),
        ],
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return SizedBox(
      height: 210,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800&q=80',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [kVino.withOpacity(0.85), kVino.withOpacity(0.1)],
                stops: const [0.0, 0.7],
              ),
            ),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: Row(
              children: [_circleBtn(Icons.arrow_back_ios_new_rounded), const SizedBox(width: 10), _circleBtn(Icons.arrow_forward_ios_rounded)],
            ),
          ),
          Positioned(top: 14, right: 14, child: _circleBtn(Icons.event_available_rounded)),
          Positioned(
            left: 18,
            bottom: 22,
            right: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.waving_hand_rounded, size: 14, color: kAmbar),
                    SizedBox(width: 6),
                    Text(
                      'Hola, Anali',
                      style: TextStyle(color: kAmbar, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: kSerif),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Septiembre 2026',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    fontFamily: kSerif,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 6, offset: Offset(0, 2))],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tu mes, tus planes',
                  style: TextStyle(color: Colors.white70, fontSize: 14, fontFamily: kSerif, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [kVino, Color(0xFF7A2650)]),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: kVino.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }

  // ---------------- CHIPS ----------------
  Widget _chips() {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _chip('Todos', Icons.apps_rounded, true, kVino),
          _chip('Trabajo', Icons.business_center_rounded, false, kAmbar),
          _chip('Personal', Icons.favorite_rounded, false, kCoral),
          _chip('Estudio', Icons.menu_book_rounded, false, kVerde),
        ],
      ),
    );
  }

  Widget _chip(String texto, IconData icon, bool activo, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        gradient: activo ? LinearGradient(colors: [color, color.withOpacity(0.75)]) : null,
        color: activo ? null : color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(activo ? 0 : 0.4)),
        boxShadow: activo ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))] : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: activo ? Colors.white : color),
          const SizedBox(width: 7),
          Text(texto, style: TextStyle(color: activo ? Colors.white : kTexto, fontWeight: FontWeight.w600, fontSize: 13.5, fontFamily: kSerif)),
        ],
      ),
    );
  }

  // ---------------- CALENDARIO ----------------
  Widget _calendario() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBF3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kVino.withOpacity(0.1), width: 1.3),
          boxShadow: [BoxShadow(color: kVino.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lun', style: TextStyle(color: kVino, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Mar', style: TextStyle(color: kVino, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Mié', style: TextStyle(color: kVino, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Jue', style: TextStyle(color: kVino, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Vie', style: TextStyle(color: kVino, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Sáb', style: TextStyle(color: kVino, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Dom', style: TextStyle(color: kVino, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            _filaSemana(['31', '1', '2', '3', '4', '5', '6']),
            const SizedBox(height: 8),
            _filaSemana(['7', '8', '9', '10', '11', '12', '13']),
            const SizedBox(height: 8),
            _filaSemana(['14', '15', '16', '17', '18', '19', '20']),
            const SizedBox(height: 8),
            _filaSemana(['21', '22', '23', '24', '25', '26', '27']),
            const SizedBox(height: 8),
            _filaSemana(['28', '29', '30', '1', '2', '3', '4']),
          ],
        ),
      ),
    );
  }

  Widget _filaSemana(List<String> dias) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: dias.map((d) => _diaWidget(d)).toList());
  }

  Widget _diaWidget(String dia) {
    final especial = diasEspeciales[dia];
    if (especial == null) {
      return Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kVino.withOpacity(0.08), width: 1),
        ),
        child: Text(dia, style: const TextStyle(fontSize: 14, color: kTexto)),
      );
    }
    if (especial['tipo'] == 'destacado' || especial['tipo'] == 'destacado2') {
      final color = especial['color'] as Color;
      return Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color, color.withOpacity(0.75)]),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 3))],
        ),
        child: Text(dia, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
      );
    }
    final color = especial['color'] as Color;
    final esEspecial = especial['tipo'] == 'especial';
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.45), width: 1.3),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(dia, style: const TextStyle(fontSize: 13, color: kTexto)),
          const SizedBox(height: 1),
          esEspecial
              ? Icon(Icons.eco, size: 9, color: color)
              : Container(width: 5, height: 5, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        ],
      ),
    );
  }

  // ---------------- FILA: FECHAS ESPECIALES + FERIADO/LEYENDA ----------------
  Widget _filaFechas() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 3, child: _fechasEspecialesCard()),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _feriadoChip(),
                  const SizedBox(height: 10),
                  Expanded(child: _leyendaCard()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fechasEspecialesCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kVerde.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kVerde.withOpacity(0.25), width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(color: kVerde, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.park_rounded, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 8),
              const Text('Fechas especiales', style: TextStyle(color: kVino, fontSize: 14.5, fontWeight: FontWeight.bold, fontFamily: kSerif)),
            ],
          ),
          const SizedBox(height: 10),
          _fechaRow('8 sep · Cochabamba · regional'),
          _fechaRow('13 sep · Junín · regional'),
          _fechaRow('14 sep · Señor de Locumba · regional'),
        ],
      ),
    );
  }

  Widget _fechaRow(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kVerde.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_florist_rounded, size: 13, color: kVerde),
            const SizedBox(width: 6),
            Expanded(child: Text(texto, style: const TextStyle(fontSize: 11, color: kTexto))),
          ],
        ),
      ),
    );
  }

  Widget _feriadoChip() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kAmbar.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kAmbar.withOpacity(0.4), width: 1.3),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: kAmbar, borderRadius: BorderRadius.circular(9)),
            child: const Icon(Icons.flag_rounded, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(children: [
                const TextSpan(text: 'Próximo feriado\n', style: TextStyle(fontSize: 9.5, color: Colors.grey)),
                const TextSpan(text: '8 oct · Angamos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.5, color: kTexto)),
              ]),
            ),
          ),
          const Icon(Icons.chevron_right, size: 16, color: kAmbar),
        ],
      ),
    );
  }

  Widget _leyendaCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kVino.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kVino.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _leyendaItem(Icons.local_florist_rounded, kVerde, 'Eventos'),
          const SizedBox(height: 8),
          _leyendaDot(kAmbar, 'Fechas regionales'),
          const SizedBox(height: 8),
          _leyendaDot(kVerde, 'Hoy'),
        ],
      ),
    );
  }

  Widget _leyendaItem(IconData icon, Color color, String texto) {
    return Row(children: [Icon(icon, size: 13, color: color), const SizedBox(width: 6), Text(texto, style: const TextStyle(fontSize: 11, color: kTexto))]);
  }

  Widget _leyendaDot(Color color, String texto) {
    return Row(children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 8),
      Text(texto, style: const TextStyle(fontSize: 11, color: kTexto)),
    ]);
  }

  // ---------------- FILA: FRASE + ENFOQUE ----------------
  Widget _filaFraseEnfoque() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _fraseCard()),
            const SizedBox(width: 10),
            Expanded(child: _enfoqueCard()),
          ],
        ),
      ),
    );
  }

  Widget _fraseCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&q=80',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kVino.withOpacity(0.25), kVino.withOpacity(0.75)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.format_quote_rounded, color: kAmbar, size: 20),
                SizedBox(height: 4),
                Text(
                  'Cada línea de código es un paso hacia lo que imaginas.',
                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: kSerif, height: 1.3),
                ),
                SizedBox(height: 8),
                Text('— Para inspirarte hoy', style: TextStyle(color: Colors.white70, fontSize: 10, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _enfoqueCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [kVino, Color(0xFF7A2650)]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: kVino.withOpacity(0.4), blurRadius: 14, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.flag_circle_rounded, color: kAmbar, size: 20),
              SizedBox(width: 6),
              Expanded(
                child: Text('Enfoque de la semana',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: kSerif)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _checkItem('Repasar programación'),
          const SizedBox(height: 8),
          _checkItem('Preparar presentación'),
        ],
      ),
    );
  }

  Widget _checkItem(String texto) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: kAmbar.withOpacity(0.9), borderRadius: BorderRadius.circular(5)),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 13),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(texto, style: const TextStyle(color: Colors.white, fontSize: 11.5))),
      ],
    );
  }

  // ---------------- FILA: EVENTOS + CONTADOR ----------------
  Widget _filaEventos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Eventos destacados', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: kVino, fontFamily: kSerif)),
              Row(children: [
                Text('Ver todo', style: TextStyle(color: kVino, fontWeight: FontWeight.bold, fontSize: 12)),
                Icon(Icons.chevron_right, color: kVino, size: 16),
              ]),
            ],
          ),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _eventoItem(kVino, Icons.groups_2_rounded, 'Reunión de equipo', '5 de septiembre · 10:00 a. m.'),
                      const SizedBox(height: 8),
                      _eventoItem(kCoral, Icons.school_rounded, 'Examen de programación', '12 de septiembre · 9:00 a. m.'),
                      const SizedBox(height: 8),
                      _eventoItem(kAmbar, Icons.assignment_turned_in_rounded, 'Entrega de laboratorio', '18 de septiembre · 11:59 p. m.'),
                      const SizedBox(height: 8),
                      _eventoItem(kVerde, Icons.insights_rounded, 'Presentación de proyecto', '21 de septiembre · 2:00 p. m.'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: _contadorCard()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventoItem(Color color, IconData icon, String titulo, String subtitulo) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3), width: 1.3),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 10),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withOpacity(0.75)]),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 6, offset: const Offset(0, 2))],
            ),
            child: Icon(icon, color: Colors.white, size: 17),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: kTexto)),
                const SizedBox(height: 2),
                Text(subtitulo, style: const TextStyle(fontSize: 10.5, color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: color, size: 18),
        ],
      ),
    );
  }

  Widget _contadorCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [kVino, Color(0xFF7A2650)]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: kVino.withOpacity(0.4), blurRadius: 14, offset: const Offset(0, 6))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(children: [
              TextSpan(text: '4 ', style: TextStyle(color: kAmbar, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: kSerif)),
              TextSpan(text: 'eventos\ndel mes', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: kSerif)),
            ]),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: 74,
            height: 74,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 74,
                  height: 74,
                  child: CircularProgressIndicator(
                    value: 0.65,
                    strokeWidth: 7,
                    backgroundColor: Colors.white.withOpacity(0.15),
                    valueColor: const AlwaysStoppedAnimation<Color>(kAmbar),
                  ),
                ),
                const Icon(Icons.event_available_rounded, color: Colors.white, size: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- BOTTOM NAV ----------------
  Widget _bottomNav() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBF3),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          border: Border.all(color: kVino.withOpacity(0.1), width: 1.3),
          boxShadow: [BoxShadow(color: kVino.withOpacity(0.15), blurRadius: 16, offset: const Offset(0, -4))],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navItem(Icons.calendar_month_rounded, 'Calendario', true),
                  _navItem(Icons.task_alt_rounded, 'Tareas', false),
                  const SizedBox(width: 56),
                  _navItem(Icons.person_rounded, 'Perfil', false),
                  const SizedBox(width: 4),
                ],
              ),
            ),
            Positioned(
              top: -20,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [kVino, kCoral]),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: kVino.withOpacity(0.5), blurRadius: 14, offset: const Offset(0, 6))],
                  border: Border.all(color: kCrema, width: 4),
                ),
                child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool activo) {
    if (activo) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [kVino, Color(0xFF7A2650)]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(children: [
          Icon(icon, color: Colors.white, size: 17),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w600)),
        ]),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: kTexto.withOpacity(0.35), size: 21),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: kTexto.withOpacity(0.35), fontSize: 10.5)),
      ],
    );
  }
}