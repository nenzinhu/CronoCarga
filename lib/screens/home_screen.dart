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
