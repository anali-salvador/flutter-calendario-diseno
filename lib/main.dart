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
      home: const CalendarioScreen(),
    );
  }
}

// Paleta de colores
const Color kCrema = Color(0xFFFBF3E8);
const Color kVino = Color(0xFF6E1E3A);
const Color kVerde = Color(0xFF2F5233);
const Color kNaranja = Color(0xFFD98C3D);
const Color kTextoOscuro = Color(0xFF3A2A2E);

class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({super.key});

  // día -> {tipo: destacado/destacado2/evento/especial, color}
  static const Map<String, Map<String, dynamic>> diasEspeciales = {
    '5': {'tipo': 'destacado', 'color': kVino},
    '21': {'tipo': 'destacado2', 'color': kVerde},
    '12': {'tipo': 'evento', 'color': kNaranja},
    '18': {'tipo': 'evento', 'color': kNaranja},
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
                  const SizedBox(height: 16),
                  _chips(),
                  const SizedBox(height: 18),
                  _calendario(),
                  const SizedBox(height: 18),
                  _fechasEspeciales(),
                  const SizedBox(height: 22),
                  _eventos(),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 210,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800&q=80',
                fit: BoxFit.cover,
              ),
              // Degradado oscuro para legibilidad del texto
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.55),
                    ],
                  ),
                ),
              ),
              // Botones circulares arriba
              Positioned(
                top: 14,
                left: 14,
                child: Row(
                  children: [
                    _circleBtn(Icons.chevron_left),
                    const SizedBox(width: 10),
                    _circleBtn(Icons.chevron_right),
                  ],
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _circleBtn(Icons.calendar_today_rounded),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: kNaranja,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Título
              const Positioned(
                left: 18,
                bottom: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Septiembre 2026',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tu mes, tus planes',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: kTextoOscuro, size: 20),
    );
  }

  // ---------------- CHIPS ----------------
  Widget _chips() {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _chip('Todos', Icons.grid_view_rounded, true, kVino),
          _chip('Trabajo', Icons.work_outline_rounded, false, kNaranja),
          _chip('Personal', Icons.favorite_border_rounded, false, kVino),
          _chip('Estudio', Icons.school_outlined, false, kVerde),
        ],
      ),
    );
  }

  Widget _chip(String texto, IconData icon, bool activo, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: activo ? color : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: activo ? color : Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: activo ? Colors.white : color),
          const SizedBox(width: 8),
          Text(
            texto,
            style: TextStyle(
              color: activo ? Colors.white : kTextoOscuro,
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
            ),
          ),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lun', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12)),
                Text('Mar', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12)),
                Text('Mié', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12)),
                Text('Jue', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12)),
                Text('Vie', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12)),
                Text('Sáb', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12)),
                Text('Dom', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            _filaSemana(['31', '1', '2', '3', '4', '5', '6']),
            const SizedBox(height: 10),
            _filaSemana(['7', '8', '9', '10', '11', '12', '13']),
            const SizedBox(height: 10),
            _filaSemana(['14', '15', '16', '17', '18', '19', '20']),
            const SizedBox(height: 10),
            _filaSemana(['21', '22', '23', '24', '25', '26', '27']),
            const SizedBox(height: 10),
            _filaSemana(['28', '29', '30', '1', '2', '3', '4']),
          ],
        ),
      ),
    );
  }

  Widget _filaSemana(List<String> dias) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dias.map((d) => _diaWidget(d)).toList(),
    );
  }

  Widget _diaWidget(String dia) {
    final especial = diasEspeciales[dia];

    if (especial == null) {
      return SizedBox(
        width: 36,
        height: 36,
        child: Center(child: Text(dia, style: const TextStyle(fontSize: 14, color: kTextoOscuro))),
      );
    }

    if (especial['tipo'] == 'destacado' || especial['tipo'] == 'destacado2') {
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: especial['color'], shape: BoxShape.circle),
        child: Center(
          child: Text(dia, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    }

    // evento o especial: número + ícono pequeño debajo
    final esEspecial = especial['tipo'] == 'especial';
    return SizedBox(
      width: 36,
      height: 36,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(dia, style: const TextStyle(fontSize: 14, color: kTextoOscuro)),
          const SizedBox(height: 2),
          esEspecial
              ? Icon(Icons.eco, size: 10, color: especial['color'])
              : Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(color: especial['color'], shape: BoxShape.circle),
                ),
        ],
      ),
    );
  }

  // ---------------- FECHAS ESPECIALES ----------------
  Widget _fechasEspeciales() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kVerde.withOpacity(0.07),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: kVerde.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.eco, color: kVerde, size: 20),
                SizedBox(width: 8),
                Text('Fechas especiales',
                    style: TextStyle(color: kTextoOscuro, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_rounded, color: kVino, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Próximo feriado nacional\n', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          TextSpan(
                            text: '8 oct · Combate de Angamos',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: kTextoOscuro),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _fechaEspecialRow('8 sep · Cochabamba · regional'),
            _fechaEspecialRow('13 sep · Junín · regional'),
            _fechaEspecialRow('14 sep · Señor de Locumba · regional'),
          ],
        ),
      ),
    );
  }

  Widget _fechaEspecialRow(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.eco, size: 14, color: kVerde),
          const SizedBox(width: 8),
          Text(texto, style: const TextStyle(fontSize: 12.5, color: kTextoOscuro)),
        ],
      ),
    );
  }

  // ---------------- EVENTOS ----------------
  Widget _eventos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Eventos destacados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextoOscuro)),
              Row(
                children: const [
                  Text('Ver todo', style: TextStyle(color: kVino, fontWeight: FontWeight.w600, fontSize: 13)),
                  Icon(Icons.chevron_right, color: kVino, size: 16),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          _eventoItem(kVino, Icons.groups_rounded, 'Reunión de equipo', '5 de septiembre · 10:00 a. m.'),
          const SizedBox(height: 10),
          _eventoItem(Colors.redAccent, Icons.school_rounded, 'Examen de programación', '12 de septiembre · 9:00 a. m.'),
          const SizedBox(height: 10),
          _eventoItem(kNaranja, Icons.event_note_rounded, 'Entrega de laboratorio', '18 de septiembre · 11:59 p. m.'),
          const SizedBox(height: 10),
          _eventoItem(kVerde, Icons.trending_up_rounded, 'Presentación de proyecto', '21 de septiembre · 2:00 p. m.'),
        ],
      ),
    );
  }

  Widget _eventoItem(Color color, IconData icon, String titulo, String subtitulo) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 62,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: kTextoOscuro)),
                const SizedBox(height: 2),
                Text(subtitulo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
          const SizedBox(width: 12),
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
        height: 78,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4))],
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
                  _navItem(Icons.calendar_today_rounded, 'Calendario', true),
                  _navItem(Icons.check_circle_outline_rounded, 'Tareas', false),
                  const SizedBox(width: 56), // espacio para el botón flotante
                  _navItem(Icons.person_outline_rounded, 'Perfil', false),
                  const SizedBox(width: 4),
                ],
              ),
            ),
            Positioned(
              top: -22,
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: kVino,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: kVino.withOpacity(0.4), blurRadius: 14, offset: const Offset(0, 6))],
                  border: Border.all(color: kCrema, width: 4),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 26),
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
        decoration: BoxDecoration(color: kVino, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey, size: 22),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}