#include "imagefinder.h"

ImageFinder::ImageFinder(QObject *parent)
    : QObject{parent}
{
    mPath=QDir::currentPath();
}

int ImageFinder::checkImgs(QString path)
{
    QStringList filters;
    filters<<"*jpg"<<"*JPEG"<<"*png"<<"*svg"<<"*webp";
    QDir dir(path);
    dir.setNameFilters(filters);
    fileList=dir.entryInfoList();
    std::reverse(fileList.begin(), fileList.end());
    maxImgs=fileList.size();
    if(maxImgs>1)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

QUrl ImageFinder::folder()
{
    mPath.prepend("file:///");
    return mPath;
}

int ImageFinder::setFolder(QUrl location)
{
    mPath=location.toString();
    mPath.remove("file:///");
    int i=checkImgs(mPath);
    return i;
}

QVariant ImageFinder::forward()
{
    iterator++;
    if(iterator>=maxImgs)
    {
        iterator=0;
    }
    QVariant path=fileList[iterator].absoluteFilePath();
    QVariant retPath=path.toString().prepend("file:///");
    return retPath;
}

QVariant ImageFinder::backward()
{
    iterator--;
    if(iterator<0)
    {
        iterator=maxImgs-1;
    }
    QVariant path=fileList[iterator].absoluteFilePath();
    QVariant retPath=path.toString().prepend("file:///");
    return retPath;
}

void ImageFinder::detectIndex(QString url)
{
    url.remove("file:///");
    QFileInfo info;
    for(int i=0; i<fileList.size(); i++)
    {
        info=fileList[i];
        if(QString(info.absoluteFilePath())==url)
        {
            iterator=i;
            break;
        }
    }
}
