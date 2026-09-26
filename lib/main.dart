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
        backgroundColor: const Color(0xFF1A1A1A), // fondo alrededor en web
        body: Center(
          child: Container(
            width: 420, // ancho tipo celular
            constraints: const BoxConstraints(maxHeight: 900),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 10)),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: const CalendarioScreen(),
          ),
        ),
      ),
    );
  }
}

// Paleta vívida
const Color kFondo = Color(0xFFF4EFE6);
const Color kMorado = Color(0xFF7C3AED);
const Color kCoral = Color(0xFFFF4D6D);
const Color kTeal = Color(0xFF00BFA6);
const Color kAmbar = Color(0xFFFFA400);
const Color kAzul = Color(0xFF3B82F6);
const Color kTexto = Color(0xFF2B2438);

class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({super.key});

  static const Map<String, Map<String, dynamic>> diasEspeciales = {
    '5': {'tipo': 'destacado', 'color': kMorado},
    '21': {'tipo': 'destacado2', 'color': kTeal},
    '12': {'tipo': 'evento', 'color': kCoral},
    '18': {'tipo': 'evento', 'color': kAmbar},
    '8': {'tipo': 'especial', 'color': kAzul},
    '13': {'tipo': 'especial', 'color': kAzul},
    '14': {'tipo': 'especial', 'color': kAzul},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFondo,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _header(),
                  Transform.translate(
                    offset: const Offset(0, -28),
                    child: _calendario(),
                  ),
                  const SizedBox(height: 4),
                  _chips(),
                  const SizedBox(height: 20),
                  _eventos(),
                  const SizedBox(height: 20),
                  _fechasEspeciales(),
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
        borderRadius: BorderRadius.circular(26),
        child: SizedBox(
          height: 190,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800&q=80',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0x996D28D9),
                      Color(0xAAFF3D68),
                    ],
                  ),
                ),
              ),
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
                          color: kAmbar,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                left: 18,
                bottom: 44,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Septiembre 2026',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('Tu mes, tus planes', style: TextStyle(color: Colors.white, fontSize: 13)),
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
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
      child: Icon(icon, color: kMorado, size: 20),
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
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: kMorado.withOpacity(0.12), width: 1.5),
          boxShadow: [
            BoxShadow(color: kMorado.withOpacity(0.15), blurRadius: 18, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lun', style: TextStyle(color: kMorado, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Mar', style: TextStyle(color: kMorado, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Mié', style: TextStyle(color: kMorado, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Jue', style: TextStyle(color: kMorado, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Vie', style: TextStyle(color: kMorado, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Sáb', style: TextStyle(color: kMorado, fontWeight: FontWeight.bold, fontSize: 12)),
                Text('Dom', style: TextStyle(color: kMorado, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dias.map((d) => _diaWidget(d)).toList(),
    );
  }

  Widget _diaWidget(String dia) {
    final especial = diasEspeciales[dia];

    if (especial == null) {
      return Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kTexto.withOpacity(0.08), width: 1),
        ),
        child: Text(dia, style: const TextStyle(fontSize: 13.5, color: kTexto)),
      );
    }

    if (especial['tipo'] == 'destacado' || especial['tipo'] == 'destacado2') {
      final color = especial['color'] as Color;
      return Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 3))],
        ),
        child: Text(dia, style: const TextStyle(fontSize: 13.5, color: Colors.white, fontWeight: FontWeight.bold)),
      );
    }

    final color = especial['color'] as Color;
    final esEspecial = especial['tipo'] == 'especial';
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.5), width: 1.4),
        color: color.withOpacity(0.08),
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

  // ---------------- CHIPS ----------------
  Widget _chips() {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _chip('Todos', Icons.grid_view_rounded, true, kMorado),
          _chip('Trabajo', Icons.work_outline_rounded, false, kAmbar),
          _chip('Personal', Icons.favorite_border_rounded, false, kCoral),
          _chip('Estudio', Icons.school_outlined, false, kAzul),
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
        border: Border.all(color: color, width: 1.4),
        boxShadow: activo ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))] : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: activo ? Colors.white : color),
          const SizedBox(width: 8),
          Text(texto, style: TextStyle(color: activo ? Colors.white : color, fontWeight: FontWeight.bold, fontSize: 13.5)),
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
              const Text(
                'EVENTOS DESTACADOS',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: kTexto, letterSpacing: 0.5),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: kMorado.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ver todo', style: TextStyle(color: kMorado, fontWeight: FontWeight.bold, fontSize: 12)),
                    Icon(Icons.arrow_forward_rounded, color: kMorado, size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _eventoItem(kMorado, Icons.groups_rounded, 'Reunión de equipo', '5 sep', '10:00 a.m.'),
          const SizedBox(height: 12),
          _eventoItem(kCoral, Icons.school_rounded, 'Examen de programación', '12 sep', '9:00 a.m.'),
          const SizedBox(height: 12),
          _eventoItem(kAmbar, Icons.event_note_rounded, 'Entrega de laboratorio', '18 sep', '11:59 p.m.'),
          const SizedBox(height: 12),
          _eventoItem(kTeal, Icons.trending_up_rounded, 'Presentación de proyecto', '21 sep', '2:00 p.m.'),
        ],
      ),
    );
  }

  Widget _eventoItem(Color color, IconData icon, String titulo, String fecha, String hora) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.16), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.4), width: 1.6),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: color.withOpacity(0.45), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: kTexto)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 11, color: color),
                    const SizedBox(width: 4),
                    Text(fecha, style: TextStyle(fontSize: 11.5, color: color, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Icon(Icons.access_time_rounded, size: 11, color: kTexto.withOpacity(0.4)),
                    const SizedBox(width: 4),
                    Text(hora, style: TextStyle(fontSize: 11.5, color: kTexto.withOpacity(0.55))),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.chevron_right, color: color, size: 18),
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kAzul.withOpacity(0.3), width: 1.6),
          boxShadow: [BoxShadow(color: kAzul.withOpacity(0.1), blurRadius: 14, offset: const Offset(0, 6))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [kAzul, Color(0xFF60A5FA)]),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(19), topRight: Radius.circular(19)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), shape: BoxShape.circle),
                    child: const Icon(Icons.eco, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'FECHAS ESPECIALES',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: kAmbar.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: kAmbar.withOpacity(0.5), width: 1.4),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(color: kAmbar, borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 18),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Próximo feriado nacional\n', style: TextStyle(fontSize: 10.5, color: Colors.grey)),
                                TextSpan(
                                  text: '8 oct · Combate de Angamos',
                                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: kTexto),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: kAmbar, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _fechaChip('8 sep · Cochabamba'),
                      _fechaChip('13 sep · Junín'),
                      _fechaChip('14 sep · Locumba'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fechaChip(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: kAzul.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kAzul.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.eco, size: 12, color: kAzul),
          const SizedBox(width: 5),
          Text(texto, style: const TextStyle(fontSize: 11, color: kAzul, fontWeight: FontWeight.w600)),
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
          border: Border.all(color: kMorado.withOpacity(0.1), width: 1.4),
          boxShadow: [BoxShadow(color: kMorado.withOpacity(0.15), blurRadius: 16, offset: const Offset(0, -4))],
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
                  const SizedBox(width: 56),
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
                  gradient: const LinearGradient(colors: [kMorado, kCoral]),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: kMorado.withOpacity(0.5), blurRadius: 14, offset: const Offset(0, 6))],
                  border: Border.all(color: kFondo, width: 4),
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
        decoration: BoxDecoration(color: kMorado, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: kTexto.withOpacity(0.4), size: 22),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: kTexto.withOpacity(0.4), fontSize: 11)),
      ],
    );
  }
}