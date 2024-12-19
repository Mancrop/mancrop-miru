import 'package:isar/isar.dart';
import 'package:miru_app/models/offline_resource.dart';

part 'download_job.g.dart';

enum DownloadStatus {
  queued,
  downloading,
  completed,
  failed,
  paused,
  canceled,
}

extension DownloadStatusExtension on DownloadStatus {
  String get status {
    switch (this) {
      case DownloadStatus.queued:
        return 'queued';
      case DownloadStatus.downloading:
        return 'downloading';
      case DownloadStatus.completed:
        return 'completed';
      case DownloadStatus.failed:
        return 'failed';
      case DownloadStatus.paused:
        return 'paused';
      case DownloadStatus.canceled:
        return 'canceled';
    }
  }

  bool get isQueued {
    return this == DownloadStatus.queued;
  }

  bool get isDownloading {
    return this == DownloadStatus.downloading;
  }

  bool get isComplete {
    return this == DownloadStatus.completed;
  }

  bool get isFailed {
    return this == DownloadStatus.failed;
  }

  bool get isPaused {
    return this == DownloadStatus.paused;
  }

  bool get isCanceled {
    return this == DownloadStatus.canceled;
  }
}

@Collection()
class DownloadJob {
  Id id = Isar.autoIncrement;
  @Enumerated(EnumType.name)
  late DownloadStatus status;

  final resource = IsarLink<OfflineResource>();
  late int progress;
}