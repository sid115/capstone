# Die Schaltung

Die Schaltungstopologie basiert auf einem klassischen einphasigen Wechselrichter. Als Eingang dient ein PV-Modulstrang mit großem DC-Link-Kondensator und Entladewiderstand. Der Wechselrichter ist als H-Brücke ausgeführt. Das AC-Signal wird mit einem Tiefpassfilter geglättet. Die Last wird über einen Transformator als galvanisch getrennter Ausgang angeschlossen. Ein STM32-Mikrocontroller steuert und regelt den Wechselrichter, indem er Schaltsignale aus einer Sinus-PWM an die Leistungshalbleiter sendet. Ein MPP-Tracker stellt dabei den Modulationsgrad für die Sinus-PWM resultierend aus der Eingangsgröße des Tiefpasskondensatorstroms bereit.

## Bullet Points

- basiert auf einem klassischen einphasigen Wechselrichter
- Eingang: PV-Modulstrang mit großem DC-Link-Kondensator und Entladewiderstand
- Wechselrichtera usgeführt als H-Brücke
- AC-Ausgang geglättet mit einem Tiefpassfilter
- Last angeschlossen über einen Transformator als galvanisch getrennter Ausgang
- Steuerung und Regelung durch einen STM32-uC
  - Sendet Schaltsignale aus einer Sinus-PWM an die Leistungshalbleiter
- MPP-Tracker:
  - Eingangsgröße: Tiefpasskondensatorstroms
  - Ausgangsgröße: Modulationsgrad für die Sinus-PWM
