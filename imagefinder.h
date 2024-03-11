#ifndef IMAGEFINDER_H
#define IMAGEFINDER_H

#include <QObject>
#include <QDir>
#include <QUrl>
#include <QDebug>
#include <QFileInfo>
#include <QVariant>

class ImageFinder : public QObject
{
    Q_OBJECT
public:
    explicit ImageFinder(QObject *parent = nullptr);
    int checkImgs(QString path);

public slots:
    QUrl folder();
    int setFolder(QUrl location);
    QVariant forward();
    QVariant backward();
    void detectIndex(QString url);
signals:
private:
    QString mPath;
    QList<QFileInfo> fileList;
    int iterator=0, maxImgs=0;
};

#endif // IMAGEFINDER_H
