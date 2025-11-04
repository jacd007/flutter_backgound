import 'package:flutter/material.dart';
import '../../../core/core_m.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _running = false;
  final TextEditingController _urlCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final isRun = await BackgroundServiceManager.isRunning();
    final url = await SharedPrefs.getString(StorageKeys.bgServiceUrl, '');
    setState(() {
      _running = isRun;
      _urlCtrl.text = url.isNotEmpty ? url : 'https://xxxxxxxxx/xxxxx';
    });
  }

  Future<void> _start() async {
    final ok = await BackgroundServiceManager.start();
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permisos denegados o GPS desactivado.')),
      );
    }
    if (mounted) setState(() => _running = ok);
  }

  Future<void> _stop() async {
    await BackgroundServiceManager.stop();
    if (mounted) setState(() => _running = false);
  }

  Future<void> _saveUrl() async {
    final url = _urlCtrl.text.trim();
    if (url.isEmpty) return;
    await SharedPrefs.setString(StorageKeys.bgServiceUrl, url);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('URL guardada')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Servicio en segundo plano')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estado: ${_running ? 'Activo' : 'Inactivo'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _urlCtrl,
                    decoration: const InputDecoration(
                      labelText: 'URL del servidor',
                      hintText: 'https://tu-servidor.com/endpoint',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveUrl,
                  child: const Text('Guardar'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: _running ? null : _start,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Iniciar servicio'),
                ),
                ElevatedButton.icon(
                  onPressed: _running ? _stop : null,
                  icon: const Icon(Icons.stop),
                  label: const Text('Detener servicio'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'El servicio seguirá activo en primer plano hasta que lo detengas.',
            ),
          ],
        ),
      ),
    );
  }
}
