# Calculadora de Carga Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refatorar a interface da Calculadora de Carga para um modelo de fluxo guiado, informativo e detalhado, utilizando Material Design 3.

**Architecture:**
- Migração de estado para um padrão reativo com `ValueNotifier` para gerenciar o fluxo guiado (entrada -> processamento -> exibição de resultados).
- Uso de `ThemeData` com `ColorScheme.fromSeed` para a nova paleta visual.
- Introdução de componentes de UI customizados (cards com elevação, indicadores de carga) para o design "premium".

**Tech Stack:** Flutter (Material 3), Google Fonts.

---

### Task 1: Setup do Tema Global e Dependências

- [ ] **Step 1: Adicionar `google_fonts`**
  Run: `dart pub add google_fonts`

- [ ] **Step 2: Configurar o `ThemeData` em `main.dart`**
  Modify: `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Carga',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
```

- [ ] **Step 3: Commit**
  Run: `git add pubspec.yaml lib/main.dart && git commit -m "feat: setup material 3 and google fonts"`

### Task 2: Refatoração da HomeScreen (Fluxo Guiado)

- [ ] **Step 1: Implementar `ActionCard` e Lógica de Estado**
  Modify: `lib/screens/home_screen.dart`

```dart
import 'package:flutter/material.dart';
import '../models/vehicle_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<bool> _isCalculated = ValueNotifier(false);
  final TextEditingController _taraController = TextEditingController();
  final TextEditingController _cargaController = TextEditingController();
  VehicleType _selectedType = VehicleType.toco;
  
  double _pbt = 0;

  void _calculate() {
    final double tara = double.tryParse(_taraController.text) ?? 0;
    final double carga = double.tryParse(_cargaController.text) ?? 0;
    _pbt = tara + carga;
    _isCalculated.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Carga')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildActionCard(),
            ValueListenableBuilder<bool>(
              valueListenable: _isCalculated,
              builder: (context, calculated, _) => calculated 
                  ? _buildResultCard() : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard() => Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButtonFormField<VehicleType>(
            value: _selectedType,
            items: VehicleType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.label))).toList(),
            onChanged: (v) => setState(() => _selectedType = v!),
            decoration: const InputDecoration(labelText: 'Tipo de Veículo'),
          ),
          TextField(controller: _taraController, decoration: const InputDecoration(labelText: 'Tara (kg)')),
          TextField(controller: _cargaController, decoration: const InputDecoration(labelText: 'Carga (kg)')),
          const SizedBox(height: 16),
          FilledButton(onPressed: _calculate, child: const Text('Calcular')),
        ],
      ),
    ),
  );

  Widget _buildResultCard() => Card(
    color: Theme.of(context).colorScheme.primaryContainer,
    margin: const EdgeInsets.only(top: 20),
    child: ListTile(
      title: Text('PBT: ${_pbt.toStringAsFixed(2)} kg'),
      subtitle: const Text('Cálculo realizado com sucesso.'),
    ),
  );
}
```

- [ ] **Step 2: Commit**
  Run: `git add lib/screens/home_screen.dart && git commit -m "feat: refactor home screen to guided flow"`
